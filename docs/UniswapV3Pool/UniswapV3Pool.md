# `UniswapV3Pool` contract

## Method Identifiers

{
  "burn(int24,int24,uint128)": "a34123a7",
  "collect(address,int24,int24,uint128,uint128)": "4f1eb3d8",
  "collectProtocol(address,uint128,uint128)": "85b66729",
  "factory()": "c45a0155",
  "fee()": "ddca3f43",
  "feeGrowthGlobal0X128()": "f3058399",
  "feeGrowthGlobal1X128()": "46141319",
  "flash(address,uint256,uint256,bytes)": "490e6cbc",
  "increaseObservationCardinalityNext(uint16)": "32148f67",
  "initialize(uint160)": "f637731d",
  "liquidity()": "1a686502",
  "maxLiquidityPerTick()": "70cf754a",
  "mint(address,int24,int24,uint128,bytes)": "3c8a7d8d",
  "observations(uint256)": "252c09d7",
  "observe(uint32[])": "883bdbfd",
  "positions(bytes32)": "514ea4bf",
  "protocolFees()": "1ad8b03b",
  "setFeeProtocol(uint8,uint8)": "8206a4d1",
  "slot0()": "3850c7bd",
  "snapshotCumulativesInside(int24,int24)": "a38807f2",
  "swap(address,bool,int256,uint160,bytes)": "128acb08",
  "tickBitmap(int16)": "5339c296",
  "tickSpacing()": "d0c93a7c",
  "ticks(int24)": "f30dba93",
  "token0()": "0dfe1681",
  "token1()": "d21220a7"
}

## Storage Layout

| Name                 | Type                                     | Slot | Offset | Bytes   |
|----------------------|------------------------------------------|------|--------|---------|
| slot0                | struct UniswapV3Pool.Slot0               | 0    | 0      | 32      |
| feeGrowthGlobal0X128 | uint256                                  | 1    | 0      | 32      |
| feeGrowthGlobal1X128 | uint256                                  | 2    | 0      | 32      |
| protocolFees         | struct UniswapV3Pool.ProtocolFees        | 3    | 0      | 32      |
| liquidity            | uint128                                  | 4    | 0      | 16      |
| ticks                | mapping(int24 => struct Tick.Info)       | 5    | 0      | 32      |
| tickBitmap           | mapping(int16 => uint256)                | 6    | 0      | 32      |
| positions            | mapping(bytes32 => struct Position.Info) | 7    | 0      | 32      |
| observations         | struct Oracle.Observation[65535]         | 8    | 0      | 2097120 |
