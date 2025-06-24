// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract TimeLock {
    address public beneficiary;
    uint256 public releaseTime;
    uint256 public amount;

    constructor(address _beneficiary, uint256 _lockDuration) payable {
        beneficiary = _beneficiary;
        releaseTime = block.timestamp + _lockDuration;
        amount = msg.value;
    }

    function release() public {
        require(block.timestamp >= releaseTime, "Funds are still locked");
        require(address(this).balance >= amount, "Insufficient balance");
        (bool success, ) = payable(beneficiary).call{value: amount}("");
        require(success, "Transfer failed");
        amount = 0;
    }

    function getRemainingTime() public view returns (uint256) {
        if (block.timestamp >= releaseTime) return 0;
        return releaseTime - block.timestamp;
    }
}
