// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StorageExample {
    uint256 public a; // 插槽 0，链上存储
    uint128 public b; // 插槽 1（低 16 字节）
    uint128 public c; // 插槽 1（高 16 字节）
    uint256 public d; // 插槽 2，链上存储

    function getSlotValues() external view returns (uint256, uint256, uint256) {
        return (a, b, c);
    }
}
