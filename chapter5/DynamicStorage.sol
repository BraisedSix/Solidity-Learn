// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DynamicStorage {
    uint256[] public arr; // 插槽 0 存储长度，元素存储在 keccak256(0) 开始
    mapping(address => uint256) public balances; // 插槽 1，键值对存储在 keccak256(key . 1)

    function pushToArray(uint256 value) external {
        arr.push(value); // 更新链上存储
    }

    function setBalance(address user, uint256 amount) external {
        balances[user] = amount; // 更新链上存储
    }

    function getArrayElement(uint256 index) external view returns (uint256) {
        return arr[index]; // 读取链上存储
    }
}
