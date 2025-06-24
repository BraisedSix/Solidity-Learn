// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract UserRegistry {
    struct User {
        string username;
        address userAddress;
        uint256 registrationTime;
    }

    mapping(address => User) public users;

    // 比较用户名是否匹配
    function compareUsername(
        string memory _username1,
        string memory _username2
    ) public pure returns (bool) {
        return
            keccak256(abi.encodePacked(_username1)) ==
            keccak256(abi.encodePacked(_username2));
    }

    // 注册用户，编码用户信息
    function register(string memory _username) public returns (bytes memory) {
        require(bytes(_username).length > 0, "Username cannot be empty");
        users[msg.sender] = User(_username, msg.sender, block.timestamp);
        return abi.encode(_username, msg.sender, block.timestamp);
    }

    // 解码用户信息
    function decodeUser(
        bytes memory _data
    )
        public
        pure
        returns (
            string memory username,
            address userAddress,
            uint256 registrationTime
        )
    {
        (username, userAddress, registrationTime) = abi.decode(
            _data,
            (string, address, uint256)
        );
    }

    // 验证用户数据
    function verifyUser(
        address _user,
        string memory _username
    ) public view returns (bool) {
        return compareUsername(users[_user].username, _username);
    }
}
