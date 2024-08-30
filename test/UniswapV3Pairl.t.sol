// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.14;

import "forge-std/Test.sol";

import {IUniswapV3Pair} from "./interfaces/IUniswapV3Pair.sol";
import {IUniswapV3Factory} from "./interfaces/IUniswapV3Factory.sol";
import {IERC20Metadata as IERC20} from "./interfaces/IERC20Metadata.sol";
import {IWETH} from "./interfaces/IWETH.sol";
import {IUSDC} from "./interfaces/IUSDC.sol";
import {IUSDT} from "./interfaces/IUSDT.sol";

contract UniswapV3PairTest is Test {

    IERC20 public constant WETH = IERC20(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    IERC20 public constant USDT = IERC20(0xdAC17F958D2ee523a2206206994597C13D831ec7);
    IERC20 public constant USDC = IERC20(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);
    IUniswapV3Factory public constant UNISWAP_V3_FACTORY = IUniswapV3Factory(0x1F98431c8aD98523631AE4a59f267346ea31F984);
    IUniswapV3Pair public constant UNISWAP_V3_PAIR = IUniswapV3Pair(0x1F98431c8aD98523631AE4a59f267346ea31F984);

    function setUp() public {
        vm.createSelectFork("mainnet", 12_369_621);
    }

}
