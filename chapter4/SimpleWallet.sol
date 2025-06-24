// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleWallet {
    event Received(address sender, uint256 amount);
    event FallbackCalled(address sender, uint256 amount, bytes data);

    // 记录接收到的以太币
    receive() external payable {
        emit Received(msg.sender, msg.value);
    }

    // 处理未知函数调用
    fallback() external payable {
        emit FallbackCalled(msg.sender, msg.value, msg.data);
    }
}
