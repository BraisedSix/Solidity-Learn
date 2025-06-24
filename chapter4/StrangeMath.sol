// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

library WeirdMath {
    function applyFactor(int self) public pure returns (int) {
        return self * 100;
    }
}

contract StrangeMath {
    using WeirdMath for int;

    function multiply(int num) public pure returns (int) {
        return num.applyFactor();
    }
}
