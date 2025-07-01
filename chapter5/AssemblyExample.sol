// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AssemblyExample {
    function add(uint256 a, uint256 b) external pure returns (uint256 result) {
        assembly {
            result := add(a, b) // EVM ADD 操作码
        }
    }

    function computeHash(bytes32 input) external pure returns (bytes32) {
        bytes32 hash;
        assembly {
            mstore(0, input)
            hash := keccak256(0, 32)
        }
        return hash;
    }

    function getCalldata() external pure returns (uint256) {
        uint256 value;
        assembly {
            // 从调用数据（calldata）的偏移量 4 字节处读取 32 字节（256 位）的数据，并存储到 value 中
            // 偏移量 4 是为了跳过调用数据的函数选择器（function selector）
            // 这里会返回0，因为 getCalldata() 没有参数，calldata 只包含 4 字节的函数选择器
            value := calldataload(4)
        }
        return value;
    }

    function storeValue(uint256 slot, uint256 value) external {
        assembly {
            sstore(slot, value) // 写入存储插槽
        }
    }
}
