// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract MemoryExplosion{

    /*
        execution cost	310 gas
    */
    function testMemoryV1()external  pure{
        uint256[10] memory myArray;
    }

    /*
        execution cost	393 gas
    */
    function testMemoryV2()external  pure{
        uint256[20] memory myArray;
    }

    /*
        execution cost	2,55,696 gas
    */
    function testMemoryV3()external  pure{
        uint256[10000] memory myArray;
    }
}


