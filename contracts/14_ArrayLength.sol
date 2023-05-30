// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract ArrayLength{
    uint256[] dynamicArray = [1,2,3,4,5,6,7,8,9,10];
    uint256[10] fixedArray = [1,2,3,4,5,6,7,8,9,10];

    /*
        - This technique only works if you expect the length of the array to be contant throughout the loop,
            and also that the array has a dynamic length.
        - If the array has fixed length, then this won't save gas.
        - When an array has fixed length the compiler knows its length and doesn't keep the value in storage.

    */

    /*
        execution cost --->	29980 gas
    */
    function getSumV1()external view returns(uint256 sum){
        for(uint i = 0; i < dynamicArray.length; i++){
            sum += dynamicArray[i];
        }
    }

    /*
        execution cost --->	28937 gas
    */
    function getSumV2()external view returns(uint256 sum){
        uint256 _length = dynamicArray.length;
        for(uint i = 0; i < _length; i++){
            sum += dynamicArray[i];
        }
    }

     /*
        execution cost --->	25411 gas
    */
    function getSumV3()external view returns(uint256 sum){
        for(uint i = 0; i < fixedArray.length; i++){
            sum += fixedArray[i];
        }
    }

    /*
        execution cost --->	25306 gas
    */
    function getSumV4()external view returns(uint256 sum){
        uint256 _length = fixedArray.length;
        for(uint i = 0; i < _length; i++){
            sum += fixedArray[i];
        }
    }

    function getSlot0ValueDynamic()external view returns(uint256 slotValue){
        assembly{
            slotValue := sload(dynamicArray.slot)
        }
    }

    function getSlot0ValueFixed()external view returns(uint256 slotValue){
        assembly{
            slotValue := sload(fixedArray.slot)
        }
    }
}