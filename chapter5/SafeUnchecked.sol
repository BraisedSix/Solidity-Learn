// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SafeUnchecked {
    function incrementCounter(uint256 count) external pure returns (uint256) {
        require(count < 1000, "Input too large"); // 手动验证
        uint256 total = 0;
        unchecked {
            for (uint256 i = 0; i < count; i++) {
                total += 1;
            }
        }
        return total;
    }
}
