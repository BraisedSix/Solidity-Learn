// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TargetContract {
    uint256 public value;

    function setValue(uint256 a, address b) external returns (uint256) {
        value = a;
        return a;
    }
}

contract EncodingComparison {
    // 使用 abi.encode 进行函数调用（需手动拼接 selector）
    function callWithEncode(
        address target,
        uint256 a,
        address b
    ) external returns (bool, bytes memory) {
        bytes4 selector = bytes4(keccak256("setValue(uint256,address)"));
        bytes memory data = abi.encode(a, b); // 仅编码参数
        bytes memory callData = abi.encodePacked(selector, data); // 拼接 selector 和参数
        (bool success, bytes memory result) = target.call(callData);
        require(success, "Call failed");
        return (success, result);
    }

    // 使用 abi.encodePacked 尝试函数调用（不推荐，可能失败）
    function callWithEncodePacked(
        address target,
        uint256 a,
        address b
    ) external returns (bool, bytes memory) {
        bytes4 selector = bytes4(keccak256("setValue(uint256,address)"));
        bytes memory data = abi.encodePacked(a, b); // 紧密打包参数
        bytes memory callData = abi.encodePacked(selector, data); // 拼接 selector
        (bool success, bytes memory result) = target.call(callData);
        // 注意：执行不报错，返回(false，0x)，因为 encodePacked 不符合 ABI 规范
        return (success, result);
    }

    // 使用 abi.encodeWithSignature 进行函数调用（推荐）
    function callWithSignature(
        address target,
        uint256 a,
        address b
    ) external returns (bool, bytes memory) {
        bytes memory data = abi.encodeWithSignature(
            "setValue(uint256,address)",
            a,
            b
        );
        (bool success, bytes memory result) = target.call(data);
        require(success, "Call failed");
        return (success, result);
    }

    // 对比三种编码结果
    function compareEncoding(
        uint256 a,
        address b
    ) external pure returns (bytes memory, bytes memory, bytes memory) {
        bytes memory encoded = abi.encode(a, b);
        bytes memory packed = abi.encodePacked(a, b);
        bytes memory withSignature = abi.encodeWithSignature(
            "setValue(uint256,address)",
            a,
            b
        );
        return (encoded, packed, withSignature);
    }
}
