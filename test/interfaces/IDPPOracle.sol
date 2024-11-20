// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

interface IDPPOracle {

    event ChangeOracle(address indexed oracle);
    event DODOFlashLoan(address borrower, address assetTo, uint256 baseAmount, uint256 quoteAmount);
    event DODOSwap(
        address fromToken, address toToken, uint256 fromAmount, uint256 toAmount, address trader, address receiver
    );
    event DisableOracle(uint256 newI);
    event EnableOracle();
    event LpFeeRateChange(uint256 newLpFeeRate);
    event OwnershipTransferPrepared(address indexed previousOwner, address indexed newOwner);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    event RChange(uint8 newRState);

    struct PMMState {
        uint256 i;
        uint256 K;
        uint256 B;
        uint256 Q;
        uint256 B0;
        uint256 Q0;
        uint8 R;
    }

    function _BASE_PRICE_CUMULATIVE_LAST_() external view returns (uint256);
    function _BASE_RESERVE_() external view returns (uint112);
    function _BASE_TARGET_() external view returns (uint112);
    function _BASE_TOKEN_() external view returns (address);
    function _BLOCK_TIMESTAMP_LAST_() external view returns (uint32);
    function _IS_OPEN_TWAP_() external view returns (bool);
    function _IS_ORACLE_ENABLED() external view returns (bool);
    function _I_() external view returns (uint128);
    function _K_() external view returns (uint64);
    function _LP_FEE_RATE_() external view returns (uint64);
    function _MAINTAINER_() external view returns (address);
    function _MT_FEE_RATE_MODEL_() external view returns (address);
    function _NEW_OWNER_() external view returns (address);
    function _OWNER_() external view returns (address);
    function _O_() external view returns (address);
    function _QUOTE_RESERVE_() external view returns (uint112);
    function _QUOTE_TARGET_() external view returns (uint112);
    function _QUOTE_TOKEN_() external view returns (address);
    function _RState_() external view returns (uint32);
    function changeOracle(address newOracle) external;
    function claimOwnership() external;
    function disableOracle(uint256 newI) external;
    function enableOracle() external;
    function flashLoan(uint256 baseAmount, uint256 quoteAmount, address _assetTo, bytes memory data) external;
    function getBaseInput() external view returns (uint256 input);
    function getMidPrice() external view returns (uint256 midPrice);
    function getPMMState() external view returns (PMMState memory state);
    function getPMMStateForCall()
        external
        view
        returns (uint256 i, uint256 K, uint256 B, uint256 Q, uint256 B0, uint256 Q0, uint256 R);
    function getQuoteInput() external view returns (uint256 input);
    function getUserFeeRate(address user) external view returns (uint256 lpFeeRate, uint256 mtFeeRate);
    function getVaultReserve() external view returns (uint256 baseReserve, uint256 quoteReserve);
    function init(
        address owner,
        address maintainer,
        address baseTokenAddress,
        address quoteTokenAddress,
        uint256 lpFeeRate,
        address mtFeeRateModel,
        uint256 k,
        uint256 i,
        address o,
        bool isOpenTWAP,
        bool isOracleEnabled
    ) external;
    function initOwner(address newOwner) external;
    function querySellBase(address trader, uint256 payBaseAmount)
        external
        view
        returns (uint256 receiveQuoteAmount, uint256 mtFee, uint8 newRState, uint256 newBaseTarget);
    function querySellQuote(address trader, uint256 payQuoteAmount)
        external
        view
        returns (uint256 receiveBaseAmount, uint256 mtFee, uint8 newRState, uint256 newQuoteTarget);
    function ratioSync() external;
    function reset(
        address assetTo,
        uint256 newLpFeeRate,
        uint256 newI,
        uint256 newK,
        uint256 baseOutAmount,
        uint256 quoteOutAmount,
        uint256 minBaseReserve,
        uint256 minQuoteReserve
    ) external returns (bool);
    function retrieve(address to, address token, uint256 amount) external;
    function sellBase(address to) external returns (uint256 receiveQuoteAmount);
    function sellQuote(address to) external returns (uint256 receiveBaseAmount);
    function transferOwnership(address newOwner) external;
    function tuneParameters(
        uint256 newLpFeeRate,
        uint256 newI,
        uint256 newK,
        uint256 minBaseReserve,
        uint256 minQuoteReserve
    ) external returns (bool);
    function tunePrice(uint256 newI, uint256 minBaseReserve, uint256 minQuoteReserve) external returns (bool);
    function version() external pure returns (string memory);

}
