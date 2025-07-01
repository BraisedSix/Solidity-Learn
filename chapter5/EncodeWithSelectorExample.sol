// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EncodeWithSelectorExample {
    function callWithSelector(
        address target,
        uint256 value
    ) external returns (bool, bytes memory) {
        bytes4 selector = bytes4(keccak256("myFunction(uint256,address)"));
        bytes memory data = abi.encodeWithSelector(selector, value, msg.sender);
        (bool success, bytes memory result) = target.call(data);
        require(success, "Call failed");
        return (success, result);
    }
}
