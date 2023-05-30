// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Regular {
    /*
        execution cost --->	601 gas
    */
    function multiplyByTwo(uint256 n) external pure returns (uint256) {
        unchecked {
            return n * 2;
        }
    }

    /*
        execution cost --->	596 gas
    */
    function divideByTwo(uint256 n) external pure returns (uint256) {
        unchecked {
            return n / 2;
        }
    }
}

contract Shift {
    /*
        execution cost --->	602 gas

        5 =  00101  = 01010

        when doing this, shifitng, multipying has the possibility of overflowing.
    */
    function multiplyByTwo(uint256 n) external pure returns (uint256) {
        unchecked {
            return n << 1;
        }
    }

    /*
        execution cost --->	580 gas

        5 =  00101  = 00010

        with division, we don't have this problem because it doesn't matter how large a number you divide.
        if the denominator is larger than the numenator, it always be zero in integer division.
    */
    function divideByTwo(uint256 n) external pure returns (uint256) {
        unchecked {
            return n >> 1;
        }
    }
}
