// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FloatingPointExample {
    // 定义缩放因子，通常为 10^18（类似以太坊的 wei）
    uint256 public constant SCALING_FACTOR = 1e18; // 10^18，18 位小数精度

    // 存储余额（以最小单位 wei 表示，模拟浮点数）
    mapping(address => uint256) public balances;

    // 错误：用于验证输入
    error InvalidAmount(string message, uint256 value);

    // 存款：输入 Ether 单位（浮点数），转换为 wei
    function deposit(uint256 etherAmount) public {
        if (etherAmount == 0) {
            revert InvalidAmount(
                "Deposit amount must be greater than zero",
                etherAmount
            );
        }
        // 模拟浮点数：将 Ether 单位乘以 10^18 转为 wei
        uint256 weiAmount = etherAmount * SCALING_FACTOR;
        balances[msg.sender] += weiAmount;
    }

    // 提取：输入 Ether 单位，转换为 wei 进行操作
    function withdraw(uint256 etherAmount) public {
        if (etherAmount == 0) {
            revert InvalidAmount(
                "Withdrawal amount must be greater than zero",
                etherAmount
            );
        }
        uint256 weiAmount = etherAmount * SCALING_FACTOR;
        require(balances[msg.sender] >= weiAmount, "Insufficient balance");
        balances[msg.sender] -= weiAmount;
    }

    // 获取余额：以 Ether 单位返回（模拟浮点数）
    function getBalanceInEther(address user) public view returns (uint256) {
        return balances[user] / SCALING_FACTOR; // 转换为 Ether 单位
    }

    // 示例：处理更精确的小数（例如 93.2355）
    function addPreciseAmount(uint256 amount, uint8 decimals) public {
        // amount 是整数部分，decimals 是小数位数
        // 例如：93.2355 -> amount = 932355, decimals = 4
        require(decimals <= 18, "Decimals exceed maximum precision");
        uint256 scalingFactor = 10 ** decimals;
        uint256 scaledAmount = (amount * SCALING_FACTOR) / scalingFactor;
        balances[msg.sender] += scaledAmount;
    }

    // 示例：计算利息（模拟浮点数运算）
    function calculateInterest(
        address user,
        uint256 rate
    ) public view returns (uint256) {
        // rate 是百分比的整数表示，例如 5% = 500（5.00%）
        // 转换为浮点数：rate / 10000
        uint256 interest = (balances[user] * rate) / 10000 / SCALING_FACTOR;
        return interest; // 返回 Ether 单位的利息
    }

    // 示例：尝试直接使用浮点数（将导致编译错误）
    // function invalidFloat() public pure returns (int256) {
    //     int256 floating = 93.6; // 错误：Type rational_const 468 / 5 is not implicitly convertible to int256
    //     return floating;
    // }
}
