// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BatchMemory {
    // 批量写入函数，接收一个uint256数组，计算其哈希值
    function batchWrite(
        uint256[] memory values
    ) external pure returns (bytes32) {
        // 声明一个bytes32变量用于存储哈希值
        bytes32 hash;
        assembly {
            // 获取空闲内存指针
            let ptr := mload(0x40)
            // 遍历输入数组
            for {
                let i := 0
            } lt(i, mload(values)) {
                i := add(i, 1)
            } {
                // 将数组元素写入内存，从ptr开始，偏移i*32字节
                mstore(
                    add(ptr, mul(i, 32)),
                    mload(add(values, add(32, mul(i, 32))))
                )
            }
            // 计算从ptr开始的数组数据的keccak256哈希值
            hash := keccak256(ptr, mul(mload(values), 32))
            // 更新空闲内存指针
            mstore(0x40, add(ptr, mul(mload(values), 32)))
        }
        // 返回计算得到的哈希值
        return hash;
    }
}
