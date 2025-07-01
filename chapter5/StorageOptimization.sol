// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StorageOptimization {
    mapping(address => uint256) public balances;

    function clearBalance(address user) external {
        delete balances[user]; // 置零退还 gas
    }
}
