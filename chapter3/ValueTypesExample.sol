// SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

contract ValueTypeExample {
    // 整数类型
    // 有符号整数 int 支持正负数
    int8 public smallSignedInt = -127; // 8位，范围 -128 到 +127
    int256 public largeSignedInt = -123456789; // 256 位，范围 -(2^255) 到 +(2^255) -1

    // 无符号整数 uint 仅支持正数
    uint8 public smallUnsignedInt = 255; // 8 位 范围 0 到 255
    uint256 public largeUnsignedInt = 123456789; // 256 位 范围 0 到  2^256 - 1

    // 地址类型
    // 表示以太坊账户地址 ，默认值为 0x0
    address public owner = msg.sender; // 当前调用者的地址
    address public zeroAddress = address(0); // 默认地址：0x000...000

    // 布尔类型
    // 表示 true 或者 false 默认值为 false
    bool public isActive = true; // 布尔值，初始化为 true
    bool public isInitialized; // 未初始化，默认为 false

    // 固定大小字节数组
    // 存储固定长度的字节序列
    // bytes1 合法输入方式
    bytes1 public singleByte = 0xFF; // 1字节，最大值 0xFF
    bytes1 public byte1Hex = 0x0A; // 十六进制，十进制 10
    bytes1 public byte1Binary = bytes1(uint8(10)); // 模拟二进制，十进制 10
    bytes1 public byte1Char = "A"; // ASCII 字符，字节值 0x41

    // bytes32 合法输入方式
    bytes32 public byte32String = "Solidity"; // 字符串转为字节
    bytes32 public longBytes =
        0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef;

    // 错误示例：直接用十进制整数
    // bytes1 public byte1Invalid = 12345; // 编译错误：Type uint256 is not implicitly convertible to bytes1

    // 示例函数：操作整数
    function updateIntegers(int8 newSmallInt, uint256 newLargeInt) public {
        smallSignedInt = newSmallInt; // 更新 int8
        largeUnsignedInt = newLargeInt; // 更新 uint256
    }

    // 示例函数：检查地址是否有效
    function isValidAddress(address addr) public pure returns (bool) {
        return addr != address(0); // 验证非零地址
    }

    // 示例函数：切换布尔值
    function toggleActive() public {
        isActive = !isActive; // 取反布尔值
    }

    // 示例函数：设置固定大小字节数组
    function setBytes32(bytes32 newBytes) public {
        longBytes = newBytes; // 更新 bytes32
    }

    // 遍历 bytes32，返回每个字节
    function traverseBytes32() public view returns (bytes1[] memory) {
        bytes1[] memory result = new bytes1[](32); // bytes32 固定 32 字节
        for (uint i = 0; i < 32; i++) {
            result[i] = longBytes[i]; // 访问第 i 个字节
        }
        return result;
    }

    // 获取 bytes1 的值（仅 1 字节，无需遍历）
    function getByte1() public view returns (bytes1) {
        return singleByte; // 直接返回
    }
}
