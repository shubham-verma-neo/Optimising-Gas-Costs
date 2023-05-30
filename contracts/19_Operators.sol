// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

    /*
       - < and > are always more efficient than <= and >=
       - <= and >= require 2 OP Codes: LT/GT and ISZERO
       - strict inequalitieson only require one OP Code: LT or GT
    */

contract LessThan{
    function lessThan(uint256 x)external pure returns(bool){
        return x < 3;
    }
}

contract LessThanE{
    /*
        PUSH
        DUP3
        GT
        ISZERO
    */
    function lessThan(uint256 x)external pure returns(bool){
        return x <= 2; // !(2 < x)
    }
}