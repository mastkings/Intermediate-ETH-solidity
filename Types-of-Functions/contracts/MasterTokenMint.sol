// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// Simplified ERC-20 Token Interface
interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
}

// Simplified ERC-20 Token Implementation
contract masterToken is IERC20 {
    string public constant name = "MasterToken";
    string public constant symbol = "MTT";
    uint8 public constant decimals = 18;

    mapping(address => uint256) private balances;
    uint256 private totalSupply_;

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action.");
        _;
    }

    function totalSupply() public view override returns (uint256) {
        return totalSupply_;
    }

    function balanceOf(address account) public view override returns (uint256) {
        return balances[account];
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        require(balances[msg.sender] >= amount, "Insufficient balance.");
        balances[msg.sender] -= amount;
        balances[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    // Mint new tokens to a specified account
    function mint(address account, uint256 amount) public onlyOwner {
        totalSupply_ += amount;
        balances[account] += amount;
        emit Transfer(address(0), account, amount);
    }

    // Burn tokens from the contract owner's balance
    function burn(uint256 amount) public onlyOwner {
        require(balances[msg.sender] >= amount, "Insufficient balance.");
        totalSupply_ -= amount;
        balances[msg.sender] -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }
}
