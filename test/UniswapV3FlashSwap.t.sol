// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import {IERC20} from "forge-std/interfaces/IERC20.sol";
import {IWETH} from "./interfaces/IWETH.sol";
import {IUniswapV3Pair as IUniswapV3Pool} from "./interfaces/IUniswapV3Pair.sol";

contract UniswapV3Flash {

    struct FlashCallbackData {
        uint256 amount0;
        uint256 amount1;
        address caller;
    }

    IUniswapV3Pool private immutable pool;
    IERC20 private immutable token0;
    IERC20 private immutable token1;

    constructor(address _pool) {
        pool = IUniswapV3Pool(_pool);
        token0 = IERC20(pool.token0());
        token1 = IERC20(pool.token1());
    }

    function flash(uint256 amount0, uint256 amount1) external {
        bytes memory data = abi.encode(FlashCallbackData({amount0: amount0, amount1: amount1, caller: msg.sender}));
        IUniswapV3Pool(pool).flash(address(this), amount0, amount1, data);
    }

    function uniswapV3FlashCallback(
        // Pool fee x amount requested
        uint256 fee0,
        uint256 fee1,
        bytes calldata data
    ) external {
        require(msg.sender == address(pool), "not authorized");

        FlashCallbackData memory decoded = abi.decode(data, (FlashCallbackData));

        // Write custom code here
        if (fee0 > 0) {
            token0.transferFrom(decoded.caller, address(this), fee0);
        }
        if (fee1 > 0) {
            token1.transferFrom(decoded.caller, address(this), fee1);
        }

        // Repay borrow
        if (fee0 > 0) {
            token0.transfer(address(pool), decoded.amount0 + fee0);
        }
        if (fee1 > 0) {
            token1.transfer(address(pool), decoded.amount1 + fee1);
        }
    }

}

contract UniswapV3FlashTest is Test {

    address constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    // DAI / WETH 0.3% fee
    address constant POOL = 0xC2e9F25Be6257c210d7Adf0D4Cd6E3E881ba25f8;
    uint24 constant POOL_FEE = 3000;

    IERC20 private constant weth = IERC20(WETH);
    IERC20 private constant dai = IERC20(DAI);
    UniswapV3Flash private uni;
    address constant user = address(11);

    function setUp() public {
        vm.createSelectFork("mainnet", 19_910_201);
        uni = new UniswapV3Flash(POOL);

        deal(DAI, user, 1e6 * 1e18);
        vm.prank(user);
        dai.approve(address(uni), type(uint256).max);
    }

    function test_flash() public {
        uint256 dai_before = dai.balanceOf(user);
        vm.prank(user);
        uni.flash(1e6 * 1e18, 0);
        uint256 dai_after = dai.balanceOf(user);

        uint256 fee = dai_before - dai_after;
        console2.log("DAI fee", fee);
    }

}
