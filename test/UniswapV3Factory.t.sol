// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.14;

import "forge-std/Test.sol";
// // import "./TestUtils.sol";
// import {IUniswapV3Factory} from "src/interfaces/IUniswapV3Factory.sol";
// import {IUniswapV3Pair} from "src/interfaces/IUniswapV3Pair.sol";
// import {IERC20} from "src/interfaces/IERC20.sol";

contract UniswapV3FactoryTest is Test {
// IERC20 public constant WETH = IERC20(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
// IERC20 public constant USDT = IERC20(0xdAC17F958D2ee523a2206206994597C13D831ec7);
// IERC20 public constant USDC = IERC20(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);
// IUniswapV3Factory public constant UNISWAP_V3_FACTORY = IUniswapV3Factory(0x1F98431c8aD98523631AE4a59f267346ea31F984);

// function setUp() public {
//     vm.createSelectFork("mainnet", 12_369_621);
// }

// function testCreatePool() public {
//     address poolAddress = UNISWAP_V3_FACTORY.createPool(address(WETH), address(USDC), 500);

// IUniswapV3Pair pool = IUniswapV3Pair(poolAddress);

// assertEq(
// UNISWAP_V3_FACTORY.getPool(address(USDC), address(WETH), 500),
// poolAddress,
// "invalid pool address in the registry"
// );

// assertEq(
//     factory.pools(address(weth), address(usdc), 500),
//     poolAddress,
//     "invalid pool address in the registry (reverse order)"
// );

// assertEq(pool.factory(), address(factory), "invalid factory address");
// assertEq(pool.token0(), address(usdc), "invalid weth address");
// assertEq(pool.token1(), address(weth), "invalid usdc address");
// assertEq(pool.tickSpacing(), 10, "invalid tick spacing");
// assertEq(pool.fee(), 500, "invalid fee");

// (
//     uint160 sqrtPriceX96,
//     int24 tick,
//     uint16 observationIndex,
//     uint16 observationCardinality,
//     uint16 observationCardinalityNext
// ) = pool.slot0();
// assertEq(sqrtPriceX96, 0, "invalid sqrtPriceX96");
// assertEq(tick, 0, "invalid tick");
// assertEq(observationIndex, 0, "invalid observation index");
// assertEq(observationCardinality, 0, "invalid observation cardinality");
// assertEq(observationCardinalityNext, 0, "invalid next observation cardinality");
// }

// function testCreatePoolUnsupportedFee() public {
//     vm.expectRevert(encodeError("UnsupportedFee()"));
//     factory.createPool(address(weth), address(usdc), 300);
// }

// function testCreatePoolIdenticalTokens() public {
//     vm.expectRevert(encodeError("TokensMustBeDifferent()"));
//     factory.createPool(address(weth), address(weth), 500);
// }

// function testCreateZeroTokenAddress() public {
//     vm.expectRevert(encodeError("ZeroAddressNotAllowed()"));
//     factory.createPool(address(weth), address(0), 500);
// }

// function testCreateAlreadyExists() public {
//     factory.createPool(address(weth), address(usdc), 500);

//     vm.expectRevert(encodeError("PoolAlreadyExists()"));
//     factory.createPool(address(weth), address(usdc), 500);
// }
}
