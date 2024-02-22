// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract AccountManager {
    uint public totalFunds = 0;
    // Function will deposit the amount required
    function depositRequire(uint _amount) public {
        // Check if the amount deposited is a positive value
        require(_amount > 0, "Deposit must be a positive value.");

        // This Update the TotalFunds
        totalFunds += _amount;
    }

    // Function will withdraw amount that is required
    function withdrawRequire(uint _amount) public {
        // Check if the amount to be withdraw is a positive value
        require(_amount > 0, "Withdrawal must be a positive value.");
        // Check if tghe amount to be withdraw is not greater than the totalFund
        require(_amount <= totalFunds, "Not enough funds for this withdrawal.");

        // This Update the TotalFunds
        totalFunds -= _amount;
    }

    // Function is required to devide two positive value 
    function divideRequire(uint _numerator, uint _denominator) public pure returns (uint) {
        // Check if the Denum is not a zero Value
        require(_denominator != 0, "Denominator cannot be zero value.");

        // Perform a devision and return a value result
        return _numerator / _denominator;
    }

    // Function the show the use of the assert statement base on the project 
    function assertFunction() public pure {
        // This Divide 100 by 0, which will trigger as division by zero error and revert the transaction
        uint result = divideRequire(100, 4);
        // Assert that the result is equal to 25, which will always fail and cause the transaction to fail
        assert(result == 3);
    }

    function revertFunction() public pure {
        // This Divide 100 by 4, which should return a value of 25
        uint result = divideRequire(100, 4);
        // Check if the result is equal to 25, and if true, revert the transaction
        if (result != 25) {
            revert("Result is not as expected.");
        }
    }
}
