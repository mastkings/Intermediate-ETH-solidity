// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

// Define a contract for handling errors through revert conditions and events for deposit and withdrawal actions
contract ErrorHandling {
    // State variable to keep track of the contract's balance
    uint public contractBalance = 0;

    // Events to log deposit and withdrawal actions
    event Deposited(uint amount);
    event Withdrawn(uint amount);

    // Custom errors for specific revert conditions
    error ZeroAmountError(string message);
    error InsufficientBalanceError(string message);
    error DivisionByZeroError();

    // Allows a user to deposit a non-zero amount into the contract
    function deposit(uint amount) public {
        if (amount == 0) {
            revert ZeroAmountError("Deposit amount must be greater than zero");
        }
        contractBalance += amount;
        emit Deposited(amount);  // Emit an event when a deposit occurs
    }

    // Allows a user to withdraw a non-zero amount if the contract has sufficient balance
    function withdraw(uint amount) public {
        if (amount == 0) {
            revert ZeroAmountError("Withdrawal amount must be greater than zero");
        }
        if (amount > contractBalance) {
            revert InsufficientBalanceError("Insufficient balance for withdrawal");
        }
        contractBalance -= amount;
        emit Withdrawn(amount);  // Emit an event when a withdrawal occurs
    }

    // Divides two numbers and ensures that the denominator is not zero
    function divide(uint numerator, uint denominator) public pure returns (uint) {
        if (denominator == 0) {
            revert DivisionByZeroError();  // Revert if attempting to divide by zero
        }
        return numerator / denominator;
    }

    // Ensures the contract balance is never negative, which should be impossible
    function checkInvariant() public view {
        // Asserting an invariant: The contract balance should never be negative
        assert(contractBalance >= 0);
    }

    // Demonstrates the use of revert to enforce certain conditions
    function conditionalRevert(bool condition) public pure {
        // Demonstrate a practical use of revert with a condition
        if (condition) {
            revert("Condition was true, transaction reverted");
        }
    }
}
