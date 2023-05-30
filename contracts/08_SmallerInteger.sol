// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

    /* 
        Note :- We cannot save STORAGE GAS by using smaller integer sizes 
        Ethereum Treats them as 32bytes
    */

contract SmallerStorage {
    uint256 private integer = 0;
    address private myAddress = address(0);
    uint256[4] private array = [0,0,0,0];
    mapping (uint256 => uint256)private myMapping;
    mapping (uint256 => mapping(uint256 => uint256))private nestedMapping;
    bool private boolean = false;

    mapping(uint128 => uint128) private mySmallMapping;
    uint128 private myInteger128;

    uint16[4] private mySmallArray;
    uint8 private myUint8;

    function setMySmallMapping() external payable {
        mySmallMapping[5] = 25;
    }

    function setMyInteger128() external payable {
        myInteger128 = 5;
    }

    function setMySmallArray() external payable {
        mySmallArray[1] = 50;
    }

    function setUint8() external payable {
        myUint8 = 3;
    }

    function setInteger()external payable {
        integer = 1;
    }

    function setBoolean()external payable {
        boolean = true;
    }

    function setMyAddress()external payable {
        myAddress = msg.sender;
    }

    function setNestedMapping()external payable {
        nestedMapping[0][1] = 6;
    }

    function setMyMapping()external payable {
        myMapping[2] = 1;
    }

    function setArray()external payable {
        array[2] = 6;
    }

}
