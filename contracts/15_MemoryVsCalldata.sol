// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract MemoryVsCalldata{

    /*
        execution cost	911 gas

        input : 0x00ff00ff
            0xb932c482
            0000000000000000000000000000000000000000000000000000000000000020
            0000000000000000000000000000000000000000000000000000000000000004
            00ff00ff00000000000000000000000000000000000000000000000000000000
        
        memory will consume more gas compare to calldata but in case of we want to mutate the memory input 
        then memory is cheaper.
    */
    function doNothingV1(bytes memory _myBytes)external pure{
        
    }

    /*
        execution cost	470 gas

        input : 0x00ff00ff
            0xf1c8954c
            0000000000000000000000000000000000000000000000000000000000000020
            0000000000000000000000000000000000000000000000000000000000000004
            00ff00ff00000000000000000000000000000000000000000000000000000000

        calldata cannot be change during the transaction. calldata is readonly that's why it consume less gas
    */
    function doNothingV2(bytes calldata _myBytes)external pure{
        
    }
}