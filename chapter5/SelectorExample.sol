// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SelectorExample {
    function myFunction(uint256 a, address b) external pure returns (uint256) {
        return a;
    }

    // 返回 Keccak256("myFunction(uint256,address)") 前 4 字节
    function getSelector() external pure returns (bytes4) {
        return this.myFunction.selector;
    }

    function computeSelectorManually() external pure returns (bytes4) {
        return bytes4(keccak256("myFunction(uint256,address)"));
    }

    function callWithKnownSelector(
        address target,
        uint256 a,
        address b
    ) external returns (bool, bytes memory) {
        bytes4 selector = this.myFunction.selector;
        bytes memory data = abi.encodeWithSelector(selector, a, b);
        (bool success, bytes memory result) = target.call(data);
        require(success, "Call failed");
        return (success, result);
    }

    function callWithExternalSelector(
        bytes4 selector,
        address target,
        uint256 a,
        address b
    ) external returns (bool, bytes memory) {
        bytes memory data = abi.encodeWithSelector(selector, a, b);
        (bool success, bytes memory result) = target.call(data);
        require(success, "Call failed");
        return (success, result);
    }
}
