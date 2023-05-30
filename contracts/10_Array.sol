// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Array{
    uint256[] private myArray;

    /*
        gas	              ->  76440 gas
        transaction cost  ->  66469 gas
        execution cost	  ->  44985 gas

        [1]
        total   -   transaction -   storing value   -   storing length of array  
        66469   -   21000       -   22000           -   22000                   

        gas	              ->  102096 gas
        transaction cost  ->  88779 gas
        execution cost	  ->  67155 gas
        
        [2,3]
        total   -   transaction -   storing value -   storing value   -  storing length of array  
        88779   -   21000       -   22000         -   22000              22000               

        gas	              ->  59546 gas
        transaction cost  ->  51779 gas
        execution cost	  ->  30155 gas
        
        [2] -> [2,9]
        total   -   transaction -   storing value(same)   -   storing value(new)    -  storing length of array  
        51779   -   21000       -   (2100 + 100)          -    22000                -  5000(2100 + 2900)                       
        
    */
    function set(uint256[] calldata _val)external{
        myArray = _val;
    }

    /*
        gas	              ->  27036 gas
        transaction cost  ->  23509 gas 
        execution cost	  ->  2445 gas


    */
    function getLength()external returns(uint256){
        return myArray.length;
    }

    /*
        gas	              ->  30662 gas
        transaction cost  ->  26662 gas 
        execution cost	  ->  5458 gas
    */
    function getSlotValue()external view returns(uint256 val){
        assembly{
            val := sload(myArray.slot)
        }
    }
}