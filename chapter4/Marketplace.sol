// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Marketplace {
    uint256 public buyCount;
    uint256 public receiveCount;
    uint256 public fallbackCount;
    mapping(address => uint256) public userBuys;
    mapping(address => uint256) public userFallbacks;

    event BuyItem(address buyer, uint256 itemId, uint256 amount);
    event ReceivedETH(address sender, uint256 amount);
    event FallbackTriggered(address sender, uint256 amount, bytes data);

    // 模拟商品购买
    function buyItem(uint256 _itemId) public payable {
        require(msg.value > 0, "Payment required");
        buyCount++;
        userBuys[msg.sender]++;
        emit BuyItem(msg.sender, _itemId, msg.value);
    }

    // fallback 函数记录未匹配调用
    fallback() external payable {
        fallbackCount++;
        userFallbacks[msg.sender]++;
        emit FallbackTriggered(msg.sender, msg.value, msg.data);
    }

    // 接收 ETH
    receive() external payable {
        receiveCount++;
        emit ReceivedETH(msg.sender, msg.value);
    }
}

contract MarketplaceCaller {
    // 测试调用不存在的函数
    function callNonExistent(address payable _marketplace) public payable {
        (bool success, ) = _marketplace.call{value: msg.value}(
            abi.encodeWithSignature("nonExistentFunction()")
        );
        require(success, "Call failed");
    }
}
