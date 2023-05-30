// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract RevertEarly{
    uint256 public x;

    /*
        gas	             --->   3000000 gas
        transaction cost --->	21910 gas 
        execution cost	 --->   706 gas    

        21,000  + Op code cost  =    21910
    */
    function revertTest(uint256 i)external {
        require(i < 3, "i must be less than 3");
        x = i;
    }
}

contract RevertLate{
    uint256 public x;

    /*
        gas	             --->   3000000 gas
        transaction cost --->	44023 gas 
        execution cost	 --->   22819 gas    

        21,000  +   22,100  + Op code cost  =    21910
    */
    function revertTest(uint256 i)external {
        x = i;
        require(i < 3, "i must be less than 3");
    }
}

contract RevertLate2{
    uint256 public x = 1;

    function multiplyOverflow(uint256 i)external view returns(uint256 result){
        result = x << i;
        require(result >= x, "overflow");
    }
}
