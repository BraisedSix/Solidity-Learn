// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ErrorHandlingExample {
    uint public balance;
    address public owner;

    // 自定义错误：提高 gas 效率和可读性
    error InsufficientBalance(uint requested, uint available);
    error InvalidInput(string message, uint value);

    constructor() {
        owner = msg.sender;
    }

    // 使用 require 验证输入
    function deposit(uint amount) public {
        require(amount > 0, "Amount must be greater than zero");
        balance += amount;
    }

    // 使用 assert 检查不变量
    function checkInvariant() public view {
        assert(balance >= 0); // 余额永远不应为负
    }

    // 使用 revert 和自定义错误处理复杂逻辑
    function withdraw(uint amount) public {
        if (amount > balance) {
            revert InsufficientBalance(amount, balance);
        }
        if (amount == 0) {
            revert InvalidInput("Withdrawal amount cannot be zero", amount);
        }
        balance -= amount;
    }

    // 使用 require 限制仅所有者操作
    function resetBalance() public {
        require(msg.sender == owner, "Only owner can reset balance");
        balance = 0;
    }

    // 获取当前余额
    function getBalance() public view returns (uint) {
        return balance;
    }
}
