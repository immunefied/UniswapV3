# `UniswapV3Router02` Contract

## Method Identifiers

{
  "WETH9()": "4aa4a4fc",
  "approveMax(address)": "571ac8b0",
  "approveMaxMinusOne(address)": "cab372ce",
  "approveZeroThenMax(address)": "639d71a9",
  "approveZeroThenMaxMinusOne(address)": "ab3fdd50",
  "callPositionManager(bytes)": "b3a2af13",
  "checkOracleSlippage(bytes,uint24,uint32)": "f25801a7",
  "checkOracleSlippage(bytes[],uint128[],uint24,uint32)": "efdeed8e",
  "exactInput((bytes,address,uint256,uint256))": "b858183f",
  "exactInputSingle((address,address,uint24,address,uint256,uint256,uint160))": "04e45aaf",
  "exactOutput((bytes,address,uint256,uint256))": "09b81346",
  "exactOutputSingle((address,address,uint24,address,uint256,uint256,uint160))": "5023b4df",
  "factory()": "c45a0155",
  "factoryV2()": "68e0d4e1",
  "getApprovalType(address,uint256)": "dee00f35",
  "increaseLiquidity((address,address,uint256,uint256,uint256))": "f100b205",
  "mint((address,address,uint24,int24,int24,uint256,uint256,address))": "11ed56c9",
  "multicall(bytes32,bytes[])": "1f0464d1",
  "multicall(bytes[])": "ac9650d8",
  "multicall(uint256,bytes[])": "5ae401dc",
  "positionManager()": "791b98bc",
  "pull(address,uint256)": "f2d5d56b",
  "refundETH()": "12210e8a",
  "selfPermit(address,uint256,uint256,uint8,bytes32,bytes32)": "f3995c67",
  "selfPermitAllowed(address,uint256,uint256,uint8,bytes32,bytes32)": "4659a494",
  "selfPermitAllowedIfNecessary(address,uint256,uint256,uint8,bytes32,bytes32)": "a4a78f0c",
  "selfPermitIfNecessary(address,uint256,uint256,uint8,bytes32,bytes32)": "c2e3140a",
  "swapExactTokensForTokens(uint256,uint256,address[],address)": "472b43f3",
  "swapTokensForExactTokens(uint256,uint256,address[],address)": "42712a67",
  "sweepToken(address,uint256)": "e90a182f",
  "sweepToken(address,uint256,address)": "df2ab5bb",
  "sweepTokenWithFee(address,uint256,address,uint256,address)": "e0e189a0",
  "sweepTokenWithFee(address,uint256,uint256,address)": "3068c554",
  "uniswapV3SwapCallback(int256,int256,bytes)": "fa461e33",
  "unwrapWETH9(uint256)": "49616997",
  "unwrapWETH9(uint256,address)": "49404b7c",
  "unwrapWETH9WithFee(uint256,address,uint256,address)": "9b2c0a37",
  "unwrapWETH9WithFee(uint256,uint256,address)": "d4ef38de",
  "wrapETH(uint256)": "1c58db4f"
}

## Storage Layout

| Name           | Type    | Slot | Offset | Bytes | Contract                                                 |
|----------------|---------|------|--------|-------|----------------------------------------------------------|
| amountInCached | uint256 | 0    | 0      | 32    | src/SwapRouter02/contracts/SwapRouter02.sol:SwapRouter02 |
