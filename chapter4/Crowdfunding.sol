// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Crowdfunding {
    address public owner;
    uint256 public totalFunded;

    constructor() {
        owner = msg.sender;
    }

    // 仅处理以太币转账
    receive() external payable {
        totalFunded += msg.value;
        emit Funded(msg.sender, msg.value);
    }

    event Funded(address contributor, uint256 amount);
}
