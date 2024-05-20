// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import {IERC20} from "forge-std/interfaces/IERC20.sol";
import {IWETH} from "src/interfaces/IWETH.sol";
import {IUniswapV3Router02 as ISwapRouter02} from "src/interfaces/IUniswapV3Router02.sol";
import {IUniswapV3Pair as IUniswapV3Pool} from "src/interfaces/IUniswapV3Pair.sol";

address constant SWAP_ROUTER_02 = 0x68b3465833fb72A70ecDF485E0e4C7bD8665Fc45;
address constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
address constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
address constant DAI_WETH_POOL_3000 = 0xC2e9F25Be6257c210d7Adf0D4Cd6E3E881ba25f8;
address constant DAI_WETH_POOL_500 = 0x60594a405d53811d3BC4766596EFD80fd545A270;
uint24 constant FEE_0 = 3000;
uint24 constant FEE_1 = 500;

contract UniswapV3FlashSwap {

    ISwapRouter02 constant router = ISwapRouter02(payable(SWAP_ROUTER_02));

    uint160 private constant MIN_SQRT_RATIO = 4_295_128_739;
    uint160 private constant MAX_SQRT_RATIO = 1_461_446_703_485_210_103_287_273_052_203_988_822_378_723_970_342;

    // DAI / WETH 0.3% swap fee (2000 DAI / WETH)
    // DAI / WETH 0.05% swap fee (2100 DAI / WETH)
    // 1. Flash swap on pool0 (receive WETH)
    // 2. Swap on pool1 (WETH -> DAI)
    // 3. Send DAI to pool0
    // profit = DAI received from pool1 - DAI repaid to pool0

    function flashSwap(address pool0, uint24 fee1, address tokenIn, address tokenOut, uint256 amountIn) external {
        bool zeroForOne = tokenIn < tokenOut;
        // 0 -> 1 => sqrt price decrease
        // 1 -> 0 => sqrt price increase
        uint160 sqrtPriceLimitX96 = zeroForOne ? MIN_SQRT_RATIO + 1 : MAX_SQRT_RATIO - 1;

        bytes memory data = abi.encode(msg.sender, pool0, fee1, tokenIn, tokenOut, amountIn, zeroForOne);

        IUniswapV3Pool(pool0).swap({
            recipient: address(this),
            zeroForOne: zeroForOne,
            amountSpecified: int256(amountIn),
            sqrtPriceLimitX96: sqrtPriceLimitX96,
            data: data
        });
    }

    function _swap(address tokenIn, address tokenOut, uint24 fee, uint256 amountIn, uint256 amountOutMin)
        private
        returns (uint256 amountOut)
    {
        IERC20(tokenIn).approve(address(router), amountIn);

        ISwapRouter02.ExactInputSingleParams memory params = ISwapRouter02.ExactInputSingleParams({
            tokenIn: tokenIn,
            tokenOut: tokenOut,
            fee: fee,
            recipient: address(this),
            amountIn: amountIn,
            amountOutMinimum: amountOutMin,
            sqrtPriceLimitX96: 0
        });

        amountOut = router.exactInputSingle(params);
    }

    function uniswapV3SwapCallback(int256 amount0, int256 amount1, bytes calldata data) external {
        // Decode data
        (
            address caller,
            address pool0,
            uint24 fee1,
            address tokenIn,
            address tokenOut,
            uint256 amountIn,
            bool zeroForOne
        ) = abi.decode(data, (address, address, uint24, address, address, uint256, bool));

        uint256 amountOut = zeroForOne ? uint256(-amount1) : uint256(-amount0);

        // pool0 -> tokenIn -> tokenOut (amountOut)
        // Swap on pool 1 (swap tokenOut -> tokenIn)
        uint256 buyBackAmount =
            _swap({tokenIn: tokenOut, tokenOut: tokenIn, fee: fee1, amountIn: amountOut, amountOutMin: amountIn});

        // Repay pool 0
        uint256 profit = buyBackAmount - amountIn;
        require(profit > 0, "profit = 0");

        IERC20(tokenIn).transfer(pool0, amountIn);
        IERC20(tokenIn).transfer(caller, profit);
    }

}

contract UniswapV3FlashTest is Test {

    IERC20 private constant dai = IERC20(DAI);
    IWETH private constant weth = IWETH(WETH);
    ISwapRouter02 private constant router = ISwapRouter02(payable(SWAP_ROUTER_02));
    IUniswapV3Pool private constant pool0 = IUniswapV3Pool(DAI_WETH_POOL_3000);
    IUniswapV3Pool private constant pool1 = IUniswapV3Pool(DAI_WETH_POOL_500);
    UniswapV3FlashSwap private flashSwap;

    uint256 private constant DAI_AMOUNT_IN = 10 * 1e18;

    function setUp() public {
        vm.createSelectFork("mainnet", 19_910_201);
        flashSwap = new UniswapV3FlashSwap();

        // Create an arbitrage opportunity - make WETH cheaper on pool0
        weth.deposit{value: 500 * 1e18}();
        weth.approve(address(router), 500 * 1e18);
        router.exactInputSingle(
            ISwapRouter02.ExactInputSingleParams({
                tokenIn: WETH,
                tokenOut: DAI,
                fee: FEE_0,
                recipient: address(0),
                amountIn: 500 * 1e18,
                amountOutMinimum: 0,
                sqrtPriceLimitX96: 0
            })
        );
    }

    function test_flashSwap() public {
        uint256 bal0 = dai.balanceOf(address(this));
        flashSwap.flashSwap({pool0: address(pool0), fee1: FEE_1, tokenIn: DAI, tokenOut: WETH, amountIn: DAI_AMOUNT_IN});
        uint256 bal1 = dai.balanceOf(address(this));
        uint256 profit = bal1 - bal0;
        assertGt(profit, 0, "profit = 0");
        console2.log("Profit %e", profit);
    }

}
