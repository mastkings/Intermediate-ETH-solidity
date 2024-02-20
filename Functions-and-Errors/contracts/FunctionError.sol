// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

/**
 * @title Error Handling in Solidity
 * @dev This contract demonstrates basic error handling patterns in Solidity using require, assert, and revert. 
 * It includes functions for depositing and withdrawing funds with checks to ensure transactions are valid. 
 * Additionally, it showcases safe division operations and conditions that trigger assertions and reverts for 
 * error handling and debugging purposes. The contract is designed for educational use, illustrating how to 
 * manage and respond to common error scenarios in smart contract development.
 *
 * Functions:
 * - depositRequire: Adds a specified amount to the contract's funds, requiring the amount to be greater than zero.
 * - withdrawRequire: Withdraws a specified amount from the contract's funds, requiring the amount to be positive and available.
 * - divideRequire: Performs division between two numbers, requiring the denominator to be non-zero to avoid division by zero errors.
 * - assertFunction: Demonstrates the use of the assert statement for internal error checking, using a division operation as an example.
 * - revertFunction: Demonstrates the use of the revert statement to manually revert transactions under specific conditions.
 */
contract ErrorHandling {
    uint public funds; // Total funds available in the contract

    // Function to deposit an amount, requiring the amount to be greater than zero
    function depositRequire(uint _amount) public {
        require(_amount > 0, "Amount must exceed zero");
        funds += _amount;
    }

    // Function to withdraw an amount, requiring the withdrawal to be positive and not exceed available funds
    function withdrawRequire(uint _amount) public {
        require(_amount > 0, "Withdrawal must be positive");
        require(_amount <= funds, "Cannot exceed available funds");
        funds -= _amount;
    }

    // Function to safely divide two numbers, requiring the denominator to be non-zero
    function divideRequire(uint _numerator, uint _denominator) public pure returns (uint) {
        require(_denominator != 0, "Denominator cannot be zero");
        return _numerator / _denominator;
    }

    // Function demonstrating the use of the assert statement for internal checks
    function assertFunction() public pure {
        uint result = divideRequire(10, 2);
        assert(result == 5);
    }

    // Function demonstrating the use of the revert statement to manually revert transactions under specific conditions
    function revertFunction() public pure {
        uint result = divideRequire(10, 2);
        if(result != 5){
            revert("Revert on specific condition");
        }
    }
}
