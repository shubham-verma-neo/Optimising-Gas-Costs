// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract SmaeValue{
    uint256 private myInteger = 1;
    uint256 private myInteger1 = 1;

    /*
        gas	             ->  27345 gas
        transaction cost ->  23778 gas 
        execution cost	 ->  2574 gas

                        debug SSTORE cost   
                                | 
        23778 - 21000 = 2778 - 2200 = 578
                                |
                           2200 - 2100      = 100  
                          Total - coldstore = value change cost
    */
    function  mayBeSet(uint256 i)external payable {
        myInteger = i;
    }

    /*
        gas	             -> 27311 gas
        transaction cost ->	23748 gas 
        execution cost	 -> 2544 gas

                        debug SLOAD cost   
                                | 
        23748 - 21000 = 2748 - 2100 = 648
                                |
                           2100 - 2100      = 0
                          Total - coldstore = value change cost

        This saving gas trick only works when you read variable before writing it

    */
    function mayBetSet1(uint256 i)external payable {
        uint256 _myInteger1 = myInteger1;
        require(_myInteger1 != 100);
        if(_myInteger1 != i){
            myInteger1 = i;
        }
    }
}