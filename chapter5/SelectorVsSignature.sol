// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SelectorVsSignature {
    function encodeBoth(
        uint256 a,
        address b
    ) external pure returns (bytes memory, bytes memory) {
        bytes memory withSignature = abi.encodeWithSignature(
            "myFunction(uint256,address)",
            a,
            b
        );
        bytes4 selector = bytes4(keccak256("myFunction(uint256,address)"));
        bytes memory withSelector = abi.encodeWithSelector(selector, a, b);
        return (withSignature, withSelector);
    }
}
