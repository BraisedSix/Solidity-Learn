// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TypeCastingExample {
    // 演示不同类型转换
    bytes1 public byte1Hex = 0x0A; // 十六进制，十进制 10
    uint256 public largeNumber = 2022;
    int16 public signedNumber = -2022;

    // 将 uint 转换为 bytes1（需显式转换）
    function setByte1FromUint(uint8 value) public {
        require(value <= 255, "Value exceeds bytes1 range");
        byte1Hex = bytes1(value); // 显式转换为 1 字节
    }

    // 将 uint 转换为 bytes2（适合更大值如 12345）
    function uintToBytes2(uint16 value) public pure returns (bytes2) {
        return bytes2(value); // 转换为 2 字节
    }

    // 示例：将 12345 转换为 bytes2
    function getBytes12345() public pure returns (bytes2) {
        return bytes2(uint16(12345)); // 12345 的字节表示，0x3039
    }

    // uint256 转换为 bytes32
    function uintToBytes() public view returns (bytes32) {
        bytes32 result = bytes32(largeNumber);
        return result; // 0x000...07e6 (2022 的 32 字节表示)
    }

    // uint256 转换为 uint8，可能丢失数据
    function uint256ToUint8() public view returns (uint8) {
        uint8 result = uint8(largeNumber); // 2022 -> 230 (仅保留最后 8 位)
        return result;
    }

    // int16 转换为 uint16，可能导致意外结果
    function signedToUnsigned() public view returns (uint16) {
        uint16 result = uint16(signedNumber); // -2022 -> 63514 (负号丢失)
        return result;
    }

    // 地址转换为 uint256
    function addressToUint(address addr) public pure returns (uint256) {
        return uint256(uint160(addr)); // 地址 (160 位) 转为 uint256
    }

    // 更新 largeNumber 以测试转换
    function setLargeNumber(uint256 newValue) public {
        largeNumber = newValue;
    }

    // 更新 signedNumber 以测试转换
    function setSignedNumber(int16 newValue) public {
        signedNumber = newValue;
    }
}
