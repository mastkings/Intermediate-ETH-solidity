// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

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
