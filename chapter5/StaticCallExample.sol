// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StaticCallExample {
    function makeStaticCall(
        address target,
        uint256 value
    ) external view returns (bool, bytes memory) {
        bytes memory data = abi.encodeWithSignature("getValue(uint256)", value);
        (bool success, bytes memory result) = target.staticcall(data);
        require(success, "Staticcall failed");
        return (success, result);
    }
}

contract TargetContract {
    function getValue(uint256 a) external pure returns (uint256) {
        return a * 2;
    }
}
