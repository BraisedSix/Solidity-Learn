// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FunctionModifierExample {
    address public owner; // 合约所有者
    uint public value; // 存储数值
    bool public paused; // 合约暂停状态

    // 构造函数：设置部署者为所有者
    constructor() {
        owner = msg.sender;
    }

    // 修饰符：仅允许所有者调用
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _; // 主函数插入点
    }

    // 修饰符：检查合约未暂停
    modifier whenNotPaused() {
        require(!paused, "Contract is paused");
        _;
    }

    // 修饰符：验证地址非零
    modifier validAddress(address addr) {
        require(addr != address(0), "Invalid address");
        _;
    }

    // 使用 onlyOwner 修饰符更新数值
    function setValue(uint newValue) public onlyOwner whenNotPaused {
        value = newValue;
    }

    // 使用 onlyOwner 切换暂停状态
    function togglePause() public onlyOwner {
        paused = !paused;
    }

    // 使用 validAddress 修饰符转移所有权
    function transferOwnership(
        address newOwner
    ) public onlyOwner validAddress(newOwner) {
        owner = newOwner;
    }

    // 获取当前状态
    function getStatus() public view returns (address, uint, bool) {
        return (owner, value, paused);
    }
}
