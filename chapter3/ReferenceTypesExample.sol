// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ReferenceTypesExample {
    // 动态大小数组：存储 uint 类型，按引用传递
    uint[] public dynamicArray;

    // 字符串：动态大小字节数组，存储 UTF-8 编码，按引用传递
    string public name = "Solidity";

    // 字节：动态大小字节数组，按引用传递
    bytes public data = hex"123456";

    // 结构体：自定义复合类型
    struct Person {
        string username;
        uint age;
        address wallet;
    }

    // 映射：键值对，address 映射到 Person 结构体
    mapping(address => Person) public users;

    // 初始化动态数组
    function initArray(uint value) public {
        dynamicArray.push(value); // 添加元素
        if (dynamicArray.length > 1) {
            dynamicArray[0] = value; // 修改第一个元素
        }
    }

    // 更新字符串
    function setName(string memory newName) public {
        name = newName; // 更新字符串
    }

    // 字节与字符串互转
    function stringToBytes(
        string memory input
    ) public pure returns (bytes memory) {
        return bytes(input); // 转换为字节
    }

    // 添加用户到映射
    function addUser(string memory username, uint age) public {
        users[msg.sender] = Person(username, age, msg.sender);
    }

    // 获取用户信息
    function getUser(
        address userAddress
    ) public view returns (string memory, uint, address) {
        Person memory user = users[userAddress];
        return (user.username, user.age, user.wallet);
    }

    // 在内存中创建固定大小数组
    function createMemoryArray(
        string memory input
    ) public pure returns (string[] memory) {
        string[] memory tempArray = new string[](2); // 固定大小
        tempArray[0] = input;
        tempArray[1] = "default";
        return tempArray;
    }
}
