// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DataLocationExample {
    uint256 public storedValue; // storage，链上存储

    function processData(uint256[] calldata input) external returns (uint256) {
        uint256 sum; // stack，临时变量
        uint256[] memory tempArray = new uint256[](input.length); // memory，临时数组
        for (uint256 i = 0; i < input.length; i++) {
            tempArray[i] = input[i]; // 从 calldata 拷贝到 memory
            sum += input[i]; // stack 操作
        }
        storedValue = sum; // 更新 storage
        return sum;
    }
}
