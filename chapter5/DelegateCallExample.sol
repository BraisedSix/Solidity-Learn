// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DelegateCallExample {
    uint256 public value;
    address public libAddress;

    function setLib(address _libAddress) external {
        libAddress = _libAddress;
    }

    function updateValue(uint256 _value) external returns (bool, bytes memory) {
        bytes memory data = abi.encodeWithSignature(
            "setValue(uint256)",
            _value
        );
        (bool success, bytes memory result) = libAddress.delegatecall(data);
        require(success, "Delegatecall failed");
        return (success, result);
    }
}

contract LibraryContract {
    uint256 public value;

    function setValue(uint256 _value) external {
        value = _value;
    }
}
