// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TargetContract {
    uint256 public value;

    function myFunction(uint256 a, address b) external returns (uint256) {
        value = a;
        return a;
    }
}

contract EncodeWithSignatureExample {
    function callWithSignature(
        address target,
        uint256 value
    ) external returns (bool, bytes memory) {
        bytes memory data = abi.encodeWithSignature(
            "myFunction(uint256,address)",
            value,
            msg.sender
        );
        (bool success, bytes memory result) = target.call(data);
        require(success, "Call failed");
        return (success, result);
    }

    function transferToken(
        address token,
        address recipient,
        uint256 amount
    ) external returns (bool, bytes memory) {
        bytes memory data = abi.encodeWithSignature(
            "transfer(address,uint256)",
            recipient,
            amount
        );
        (bool success, bytes memory result) = token.call(data);
        require(success, "Token transfer failed");
        return (success, result);
    }
}
