// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CallExample {
    function makeCall(
        address target,
        uint256 value
    ) external payable returns (bool, bytes memory) {
        bytes memory data = abi.encodeWithSignature("setValue(uint256)", value);
        (bool success, bytes memory result) = target.call{value: msg.value}(
            data
        );
        require(success, "Call failed");
        return (success, result);
    }
}

contract TargetContract {
    uint256 public value;

    function setValue(uint256 _value) external {
        value = _value;
    }
}
