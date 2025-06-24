// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Proxy {
    address public implementation; // 目标合约地址

    constructor(address _implementation) {
        implementation = _implementation;
    }

    // 转发所有未知调用到目标合约
    fallback() external payable {
        (bool success, bytes memory data) = implementation.delegatecall(
            msg.data
        );
        require(success, "Delegatecall failed");
    }
}
