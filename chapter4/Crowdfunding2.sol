// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Crowdfunding {
    address public owner;
    uint256 public goal;
    uint256 public raisedAmount;
    mapping(address => uint256) public contributions;

    constructor(uint256 _goal) {
        owner = msg.sender;
        goal = _goal;
    }

    // 接收 ETH
    receive() external payable {
        require(raisedAmount < goal, "Goal already reached");
        contributions[msg.sender] += msg.value;
        raisedAmount += msg.value;
    }

    // 提取资金（仅限拥有者）
    function withdraw() public {
        require(msg.sender == owner, "Only owner can withdraw");
        require(raisedAmount >= goal, "Goal not reached");
        (bool success, ) = payable(owner).call{value: address(this).balance}(
            ""
        );
        require(success, "Transfer failed");
    }

    // 退款给贡献者
    function refund(address _contributor) public {
        require(msg.sender == owner, "Only owner can refund");
        uint256 amount = contributions[_contributor];
        require(amount > 0, "No contribution found");
        contributions[_contributor] = 0;
        raisedAmount -= amount;
        (bool success, ) = payable(_contributor).call{value: amount}("");
        require(success, "Refund failed");
    }
}
