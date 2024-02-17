// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// Interface for ERC-20 Token Standard
interface IERC20 {
    // Returns the total token supply
    function totalSupply() external view returns (uint256);

    // Returns the account balance of another account with address `account`
    function balanceOf(address account) external view returns (uint256);

    // Transfers `amount` tokens to address `recipient`, and MUST fire the `Transfer` event
    function transfer(address recipient, uint256 amount) external returns (bool);

    // Returns the remaining number of tokens that `spender` will be allowed to spend on behalf of `owner`
    function allowance(address owner, address spender) external view returns (uint256);

    // Sets `amount` as the allowance of `spender` over the caller's tokens, and MUST fire the `Approval` event
    function approve(address spender, uint256 amount) external returns (bool);

    // Transfers `amount` tokens from `sender` to `recipient` using the allowance mechanism, and MUST fire the `Transfer` event
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    // MUST trigger when tokens are transferred, including zero value transfers
    event Transfer(address indexed from, address indexed to, uint256 value);

    // MUST trigger on any successful call to `approve(address spender, uint256 value)`
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

// Implementation of the IERC20 interface
contract MasterToken is IERC20 {
    string public constant name = "Eth Master Token"; // Token name
    string public constant symbol = "MTT"; // Token symbol
    uint8 public constant decimals = 18; // Token decimals

    // Mapping from account addresses to their balances
    mapping(address => uint256) private _balances;

    // Mapping from account addresses to another account's allowed withdrawal amount
    mapping(address => mapping(address => uint256)) private _allowances;

    // Total supply of tokens
    uint256 private _totalSupply;

    // Owner of the contract (who can mint new tokens)
    address public owner;

    // Sets the creator of the contract as the initial owner
    constructor() {
        owner = msg.sender;
    }

    // Modifier to restrict certain functions to only the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action!");
        _;
    }

    // Returns the total token supply
    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
    }

    // Returns the balance of a specific account
    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }

    // Transfers tokens to a specified address
    function transfer(address recipient, uint256 amount) public override returns (bool) {
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");
        _balances[msg.sender] -= amount;
        _balances[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    // Creates `amount` tokens and assigns them to `account`, increasing the total supply
    function mint(address account, uint256 amount) public onlyOwner {
        _totalSupply += amount;
        _balances[account] += amount;
        emit Transfer(address(0), account, amount);
    }

    // Destroys `amount` tokens from the caller, reducing the total supply
    function burn(uint256 amount) public {
        require(_balances[msg.sender] >= amount, "Insufficient balance");
        _totalSupply -= amount;
        _balances[msg.sender] -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }

    // Returns the amount which `spender` is still allowed to withdraw from `owner`
    function allowance(address owner, address spender) public view override returns (uint256) {
        return _allowances[owner][spender];
    }

    // Sets `amount` as the allowance of `spender` over the caller's tokens
    function approve(address spender, uint256 amount) public override returns (bool) {
        _allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    // Transfers `amount` tokens from `sender` to `recipient` using the allowance mechanism
    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        require(_balances[sender] >= amount, "Insufficient balance");
        require(_allowances[sender][msg.sender] >= amount, "Insufficient allowance");
        _balances[sender] -= amount;
        _balances[recipient] += amount;
        _allowances[sender][msg.sender] -= amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }
}
