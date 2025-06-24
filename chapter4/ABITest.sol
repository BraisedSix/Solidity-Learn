// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ABITest {
    // 编码示例
    function encode(
        address _addr,
        uint256 _value
    ) public pure returns (bytes memory) {
        return abi.encode(_addr, _value);
    }

    // 紧凑编码示例
    function encodePacked(
        address _addr,
        uint256 _value
    ) public pure returns (bytes memory) {
        return abi.encodePacked(_addr, _value);
    }

    // 解码示例
    function decode(bytes memory data) public pure returns (address, uint256) {
        return abi.decode(data, (address, uint256));
    }

    // 调用其他合约
    function callContract(
        address _contract,
        address _addr,
        uint256 _value
    ) public {
        bytes memory data = abi.encodeWithSignature(
            "targetFunction(address,uint256)",
            _addr,
            _value
        );
        (bool success, ) = _contract.call(data);
        require(success, "Call failed");
    }

    // 生成哈希（使用 encodePacked）
    function hashData(
        string memory _str1,
        string memory _str2
    ) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_str1, _str2));
    }
}
