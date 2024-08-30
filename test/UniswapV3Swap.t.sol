// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import {IERC20} from "forge-std/interfaces/IERC20.sol";
import {IWETH} from "./interfaces/IWETH.sol";
import {IUniswapV3Router02 as ISwapRouter02} from "./interfaces/IUniswapV3Router02.sol";
import {IUniswapV3Router02 as ISwapRouter02} from "./interfaces/IUniswapV3Router02.sol";

address constant SWAP_ROUTER_02 = 0x68b3465833fb72A70ecDF485E0e4C7bD8665Fc45;
address constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
address constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
address constant USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;

contract UniswapV3SingleHopSwap {

    ISwapRouter02 private constant router = ISwapRouter02(payable(SWAP_ROUTER_02));
    IERC20 private constant weth = IERC20(WETH);
    IERC20 private constant dai = IERC20(DAI);

    function swapExactInputSingleHop(uint256 amountIn, uint256 amountOutMin) external {
        weth.transferFrom(msg.sender, address(this), amountIn);
        weth.approve(address(router), amountIn);

        ISwapRouter02.ExactInputSingleParams memory params = ISwapRouter02.ExactInputSingleParams({
            tokenIn: WETH,
            tokenOut: DAI,
            fee: 3000,
            recipient: msg.sender,
            amountIn: amountIn,
            amountOutMinimum: amountOutMin,
            sqrtPriceLimitX96: 0
        });

        router.exactInputSingle(params);
    }

    function swapExactOutputSingleHop(uint256 amountOut, uint256 amountInMax) external {
        weth.transferFrom(msg.sender, address(this), amountInMax);
        weth.approve(address(router), amountInMax);

        ISwapRouter02.ExactOutputSingleParams memory params = ISwapRouter02.ExactOutputSingleParams({
            tokenIn: WETH,
            tokenOut: DAI,
            fee: 3000,
            recipient: msg.sender,
            amountOut: amountOut,
            amountInMaximum: amountInMax,
            sqrtPriceLimitX96: 0
        });

        uint256 amountIn = router.exactOutputSingle(params);

        if (amountIn < amountInMax) {
            weth.approve(address(router), 0);
            weth.transfer(msg.sender, amountInMax - amountIn);
        }
    }

}

contract UniswapV3MultiHopSwap {

    ISwapRouter02 private constant router = ISwapRouter02(payable(SWAP_ROUTER_02));
    IERC20 private constant weth = IERC20(WETH);
    IERC20 private constant dai = IERC20(DAI);

    function swapExactInputMultiHop(uint256 amountIn, uint256 amountOutMin) external {
        weth.transferFrom(msg.sender, address(this), amountIn);
        weth.approve(address(router), amountIn);

        bytes memory path = abi.encodePacked(WETH, uint24(3000), USDC, uint24(100), DAI);

        ISwapRouter02.ExactInputParams memory params = ISwapRouter02.ExactInputParams({
            path: path,
            recipient: msg.sender,
            amountIn: amountIn,
            amountOutMinimum: amountOutMin
        });

        router.exactInput(params);
    }

    function swapExactOutputMultiHop(uint256 amountOut, uint256 amountInMax) external {
        weth.transferFrom(msg.sender, address(this), amountInMax);
        weth.approve(address(router), amountInMax);

        bytes memory path = abi.encodePacked(DAI, uint24(100), USDC, uint24(3000), WETH);

        ISwapRouter02.ExactOutputParams memory params = ISwapRouter02.ExactOutputParams({
            path: path,
            recipient: msg.sender,
            amountOut: amountOut,
            amountInMaximum: amountInMax
        });

        uint256 amountIn = router.exactOutput(params);

        if (amountIn < amountInMax) {
            weth.approve(address(router), 0);
            weth.transfer(msg.sender, amountInMax - amountIn);
        }
    }

}

contract UniswapV3SingleHopSwapTest is Test {

    address private constant DAI_WETH_POOL_3000 = 0xC2e9F25Be6257c210d7Adf0D4Cd6E3E881ba25f8;

    IWETH private constant weth = IWETH(WETH);
    IERC20 private constant dai = IERC20(DAI);

    UniswapV3SingleHopSwap private swap;

    uint256 private constant AMOUNT_IN = 1e18;
    uint256 private constant AMOUNT_OUT = 50 * 1e18;
    uint256 private constant MAX_AMOUNT_IN = 1e18;

    function setUp() public {
        vm.createSelectFork("mainnet", 19_910_201);
        swap = new UniswapV3SingleHopSwap();
        weth.deposit{value: AMOUNT_IN + MAX_AMOUNT_IN}();
        weth.approve(address(swap), type(uint256).max);
    }

    function test_swapExactInputSingleHop() public {
        swap.swapExactInputSingleHop(AMOUNT_IN, 1);
        uint256 d1 = dai.balanceOf(address(this));
        assertGt(d1, 0, "DAI balance = 0");
    }

    function test_swapExactOutputSingleHop() public {
        uint256 w0 = weth.balanceOf(address(this));
        uint256 d0 = dai.balanceOf(address(this));
        swap.swapExactOutputSingleHop(AMOUNT_OUT, MAX_AMOUNT_IN);
        uint256 w1 = weth.balanceOf(address(this));
        uint256 d1 = dai.balanceOf(address(this));

        assertLt(w1, w0, "WETH balance didn't decrease");
        assertGt(d1, d0, "DAI balance didn't increase");
        assertEq(weth.balanceOf(address(swap)), 0, "WETH balance of swap != 0");
        assertEq(dai.balanceOf(address(swap)), 0, "DAI balance of swap != 0");
    }

}

contract UniswapV3MultiHopSwapTest is Test {

    IWETH private constant weth = IWETH(WETH);
    IERC20 private constant dai = IERC20(DAI);
    IERC20 private constant usdc = IERC20(USDC);

    UniswapV3MultiHopSwap private swap;

    uint256 private constant AMOUNT_IN = 10 * 1e18;
    uint256 private constant AMOUNT_OUT = 20 * 1e18;
    uint256 private constant MAX_AMOUNT_IN = 1e18;

    function setUp() public {
        vm.createSelectFork("mainnet", 19_910_201);
        swap = new UniswapV3MultiHopSwap();
        weth.deposit{value: AMOUNT_IN + MAX_AMOUNT_IN}();
        weth.approve(address(swap), type(uint256).max);
    }

    function test_swapExactInputMultiHop() public {
        swap.swapExactInputMultiHop(AMOUNT_IN, 1);
        uint256 d1 = dai.balanceOf(address(this));
        assertGt(d1, 0, "DAI balance = 0");
    }

    function test_swapExactOutputMultiHop() public {
        uint256 w0 = weth.balanceOf(address(this));
        uint256 d0 = dai.balanceOf(address(this));
        swap.swapExactOutputMultiHop(AMOUNT_OUT, MAX_AMOUNT_IN);
        uint256 w1 = weth.balanceOf(address(this));
        uint256 d1 = dai.balanceOf(address(this));

        assertLt(w1, w0, "WETH balance didn't decrease");
        assertGt(d1, d0, "DAI balance didn't increase");
        assertEq(weth.balanceOf(address(swap)), 0, "WETH balance of swap != 0");
        assertEq(dai.balanceOf(address(swap)), 0, "DAI balance of swap != 0");
    }

}
