# `UniswapV3Factory` contract

## Method Identifiers

{
  "createPool(address,address,uint24)": "a1671295",
  "enableFeeAmount(uint24,int24)": "8a7c195f",
  "feeAmountTickSpacing(uint24)": "22afcccb",
  "getPool(address,address,uint24)": "1698ee82",
  "owner()": "8da5cb5b",
  "parameters()": "89035730",
  "setOwner(address)": "13af4035"
}

## Storage Layout

| Name                 | Type                                                               | Slot | Offset | Bytes |
|----------------------|--------------------------------------------------------------------|------|--------|-------|
| parameters           | struct UniswapV3PoolDeployer.Parameters                            | 0    | 0      | 96    |
| owner                | address                                                            | 3    | 0      | 20    |
| feeAmountTickSpacing | mapping(uint24 => int24)                                           | 4    | 0      | 32    |
| getPool              | mapping(address => mapping(address => mapping(uint24 => address))) | 5    | 0      | 32    |
