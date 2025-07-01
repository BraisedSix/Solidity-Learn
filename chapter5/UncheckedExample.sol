// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UncheckedExample {
    function safeAdd(uint256 a, uint256 b) external pure returns (uint256) {
        return a + b; // 默认溢出检查
    }

    function unsafeAdd(uint256 a, uint256 b) external pure returns (uint256) {
        unchecked {
            return a + b; // 无溢出检查
        }
    }

    function sumUnchecked(uint256 n) external pure returns (uint256) {
        uint256 total = 0;
        unchecked {
            for (uint256 i = 0; i < n; i++) {
                total += i; // 节省每次循环的溢出检查
            }
        }
        return total;
    }
}
