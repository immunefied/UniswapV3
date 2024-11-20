// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

interface CurveFactoryVolt {

    event Approval(address indexed owner, address indexed spender, uint256 value);
    event Deposit(address indexed recipient, uint256 shares, uint256 amount);
    event EmergencyShutdown(bool active);
    event FeeReport(uint256 management_fee, uint256 performance_fee, uint256 strategist_fee, uint256 duration);
    event LockedProfitDegradationUpdated(uint256 value);
    event NewPendingGovernance(address indexed pendingGovernance);
    event StrategyAdded(
        address indexed strategy,
        uint256 debtRatio,
        uint256 minDebtPerHarvest,
        uint256 maxDebtPerHarvest,
        uint256 performanceFee
    );
    event StrategyAddedToQueue(address indexed strategy);
    event StrategyMigrated(address indexed oldVersion, address indexed newVersion);
    event StrategyRemovedFromQueue(address indexed strategy);
    event StrategyReported(
        address indexed strategy,
        uint256 gain,
        uint256 loss,
        uint256 debtPaid,
        uint256 totalGain,
        uint256 totalLoss,
        uint256 totalDebt,
        uint256 debtAdded,
        uint256 debtRatio
    );
    event StrategyRevoked(address indexed strategy);
    event StrategyUpdateDebtRatio(address indexed strategy, uint256 debtRatio);
    event StrategyUpdateMaxDebtPerHarvest(address indexed strategy, uint256 maxDebtPerHarvest);
    event StrategyUpdateMinDebtPerHarvest(address indexed strategy, uint256 minDebtPerHarvest);
    event StrategyUpdatePerformanceFee(address indexed strategy, uint256 performanceFee);
    event Sweep(address indexed token, uint256 amount);
    event Transfer(address indexed sender, address indexed receiver, uint256 value);
    event UpdateDepositLimit(uint256 depositLimit);
    event UpdateGovernance(address governance);
    event UpdateGuardian(address guardian);
    event UpdateManagement(address management);
    event UpdateManagementFee(uint256 managementFee);
    event UpdatePerformanceFee(uint256 performanceFee);
    event UpdateRewards(address rewards);
    event UpdateWithdrawalQueue(address[20] queue);
    event Withdraw(address indexed recipient, uint256 shares, uint256 amount);
    event WithdrawFromStrategy(address indexed strategy, uint256 totalDebt, uint256 loss);

    function DOMAIN_SEPARATOR() external view returns (bytes32);
    function acceptGovernance() external;
    function activation() external view returns (uint256);
    function addStrategy(
        address strategy,
        uint256 debtRatio,
        uint256 minDebtPerHarvest,
        uint256 maxDebtPerHarvest,
        uint256 performanceFee
    ) external;
    function addStrategyToQueue(address strategy) external;
    function allowance(address arg0, address arg1) external view returns (uint256);
    function apiVersion() external pure returns (string memory);
    function approve(address spender, uint256 amount) external returns (bool);
    function availableDepositLimit() external view returns (uint256);
    function balanceOf(address arg0) external view returns (uint256);
    function creditAvailable() external view returns (uint256);
    function creditAvailable(address strategy) external view returns (uint256);
    function debtOutstanding() external view returns (uint256);
    function debtOutstanding(address strategy) external view returns (uint256);
    function debtRatio() external view returns (uint256);
    function decimals() external view returns (uint256);
    function decreaseAllowance(address spender, uint256 amount) external returns (bool);
    function deposit() external returns (uint256);
    function deposit(uint256 _amount) external returns (uint256);
    function deposit(uint256 _amount, address recipient) external returns (uint256);
    function depositLimit() external view returns (uint256);
    function emergencyShutdown() external view returns (bool);
    function expectedReturn() external view returns (uint256);
    function expectedReturn(address strategy) external view returns (uint256);
    function governance() external view returns (address);
    function guardian() external view returns (address);
    function increaseAllowance(address spender, uint256 amount) external returns (bool);
    function initialize(
        address token,
        address governance,
        address rewards,
        string memory nameOverride,
        string memory symbolOverride
    ) external;
    function initialize(
        address token,
        address governance,
        address rewards,
        string memory nameOverride,
        string memory symbolOverride,
        address guardian
    ) external;
    function initialize(
        address token,
        address governance,
        address rewards,
        string memory nameOverride,
        string memory symbolOverride,
        address guardian,
        address management
    ) external;
    function lastReport() external view returns (uint256);
    function lockedProfit() external view returns (uint256);
    function lockedProfitDegradation() external view returns (uint256);
    function management() external view returns (address);
    function managementFee() external view returns (uint256);
    function maxAvailableShares() external view returns (uint256);
    function migrateStrategy(address oldVersion, address newVersion) external;
    function name() external view returns (string memory);
    function nonces(address arg0) external view returns (uint256);
    function performanceFee() external view returns (uint256);
    function permit(address owner, address spender, uint256 amount, uint256 expiry, bytes memory signature)
        external
        returns (bool);
    function pricePerShare() external view returns (uint256);
    function removeStrategyFromQueue(address strategy) external;
    function report(uint256 gain, uint256 loss, uint256 _debtPayment) external returns (uint256);
    function revokeStrategy() external;
    function revokeStrategy(address strategy) external;
    function rewards() external view returns (address);
    function setDepositLimit(uint256 limit) external;
    function setEmergencyShutdown(bool active) external;
    function setGovernance(address governance) external;
    function setGuardian(address guardian) external;
    function setLockedProfitDegradation(uint256 degradation) external;
    function setManagement(address management) external;
    function setManagementFee(uint256 fee) external;
    function setName(string memory name) external;
    function setPerformanceFee(uint256 fee) external;
    function setRewards(address rewards) external;
    function setSymbol(string memory symbol) external;
    function setWithdrawalQueue(address[20] memory queue) external;
    // function strategies(address arg0)
    // external
    // view
    // returns ((uint256, uint256, uint256, uint256, uint256, uint256, uint256, uint256, uint256) memory);
    function sweep(address token) external;
    function sweep(address token, uint256 amount) external;
    function symbol() external view returns (string memory);
    function token() external view returns (address);
    function totalAssets() external view returns (uint256);
    function totalDebt() external view returns (uint256);
    function totalIdle() external view returns (uint256);
    function totalSupply() external view returns (uint256);
    function transfer(address receiver, uint256 amount) external returns (bool);
    function transferFrom(address sender, address receiver, uint256 amount) external returns (bool);
    function updateStrategyDebtRatio(address strategy, uint256 debtRatio) external;
    function updateStrategyMaxDebtPerHarvest(address strategy, uint256 maxDebtPerHarvest) external;
    function updateStrategyMinDebtPerHarvest(address strategy, uint256 minDebtPerHarvest) external;
    function updateStrategyPerformanceFee(address strategy, uint256 performanceFee) external;
    function withdraw() external returns (uint256);
    function withdraw(uint256 maxShares) external returns (uint256);
    function withdraw(uint256 maxShares, address recipient) external returns (uint256);
    function withdraw(uint256 maxShares, address recipient, uint256 maxLoss) external returns (uint256);
    function withdrawalQueue(uint256 arg0) external view returns (address);

}
