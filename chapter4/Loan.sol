// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

library FinancialMath {
    uint256 private constant PRECISION = 1e18;

    function calculateInterest(
        uint256 principal,
        uint256 rate,
        uint256 time
    ) public pure returns (uint256) {
        return (principal * rate * time) / PRECISION;
    }

    function addAmount(
        uint256 base,
        uint256 amount
    ) public pure returns (uint256) {
        return base + amount;
    }
}

contract Loan {
    using FinancialMath for uint256;

    uint256 public totalLoan;
    uint256 public constant RATE = 5e16; // 5% 利率

    function issueLoan(uint256 _amount, uint256 _duration) public {
        uint256 interest = _amount.calculateInterest(RATE, _duration);
        totalLoan = _amount.addAmount(interest);
    }

    function getTotalLoan() public view returns (uint256) {
        return totalLoan;
    }
}
