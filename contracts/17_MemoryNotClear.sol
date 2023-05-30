// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract MemoryNotClear {
    /*
        execution cost	8218 gas
    */
    function testMemoryV1() external pure {
        uint256[1000] memory myArray;
    }

    /*
        execution cost	258643 gas
    */
    function testMemoryV2() external pure {
        uint256[10000] memory myArray;
    }

    /*
        execution cost	258643 gas
    */
    function testMemoryV3() external pure {
        for (uint256 i = 0; i < 10; i++) {
            allocateMemory();
        }
    }

    function allocateMemory() internal pure {
        uint256[1000] memory myArray;
    }
}
