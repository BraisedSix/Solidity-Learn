// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract EtherWallet {
    mapping(address => uint256) public balances;

    // 接收Ether
    receive() external payable {
        balances[msg.sender] += msg.value;
    }

    // 使用transfer发送Ether
    function sendViaTransfer(
        address payable recipient,
        uint256 amount
    ) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        recipient.transfer(amount);
    }

    // 使用send发送Ether
    function sendViaSend(address payable recipient, uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        bool success = recipient.send(amount);
        require(success, "Send failed");
    }

    // 使用call发送Ether（推荐）
    function sendViaCall(address payable recipient, uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        (bool success, ) = recipient.call{value: amount}("");
        require(success, "Call failed");
    }

    // 查询余额
    function getBalance() external view returns (uint) {
        return balances[msg.sender];
    }
}
