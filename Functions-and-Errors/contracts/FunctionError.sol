// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title Error Handling Contract
 * @dev This contract demonstrates error handling in Solidity using custom errors, events, and require statements.
 * It allows for depositing and withdrawing Ether and includes basic arithmetic operations with error checks.
 */
contract ErrorHandling {
    /// @notice Tracks the Ether balance stored in this contract
    uint256 public contractBalance;

    /// @dev Emitted when Ether is deposited into the contract
    event Deposit(uint256 amount);

    /// @dev Emitted when Ether is withdrawn from the contract
    event Withdrawal(uint256 amount);

    /// @notice Custom error for attempting an operation with a zero amount
    error ZeroAmountError();

    /// @notice Custom error for insufficient balance during withdrawal
    error InsufficientBalanceError();

    /// @notice Custom error for division operations where the denominator is zero
    error DivisionByZeroError();

    /**
     * @notice Deposits Ether into the contract
     * @param amount The amount of Ether to deposit
     */
    function deposit(uint256 amount) external {
        require(amount > 0, "Deposit amount must be greater than zero");
        contractBalance += amount;
        emit Deposit(amount);
    }

    /**
     * @notice Withdraws Ether from the contract
     * @param amount The amount of Ether to withdraw
     */
    function withdraw(uint256 amount) external {
        require(amount > 0, "Withdrawal amount must be greater than zero");
        require(amount <= contractBalance, "Insufficient balance for withdrawal");
        contractBalance -= amount;
        emit Withdrawal(amount);
    }

    /**
     * @notice Divides one number by another
     * @param numerator The numerator in the division
     * @param denominator The denominator in the division
     * @return The result of the division
     */
    function divide(uint256 numerator, uint256 denominator) external pure returns (uint256) {
        require(denominator != 0, "Cannot divide by zero");
        return numerator / denominator;
    }

    /**
     * @notice Ensures the contract's balance is never negative
     * @dev This function uses assert for invariant checking as the balance should never be negative
     */
    function checkInvariant() external view {
        assert(contractBalance >= 0);
    }

    /**
     * @notice Demonstrates a conditional revert
     * @param condition The condition to evaluate
     */
    function conditionalRevert(bool condition) external pure {
        require(!condition, "Condition was true, transaction reverted");
    }
}
