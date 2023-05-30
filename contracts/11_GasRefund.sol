// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract GasRefund{
    uint256 private berlinVar1 = 1;
    /*
    gas	              --->  47403 gas
    transaction cost  --->	13110 gas 
    execution cost	  --->  5156 gas

    Yellow Paper - Rsclear  =   15,000 refund max, in Berlin Environment this will be different 
    for other Environment

                setting !0 -> 0
        21,000  +   5,000   +  200    =   26,200 
                26,200      -  15,000 =   11,200  not possible
                26,200      /  2      =   13,100  paid gas
                    
        if total gas spending is less than 2 * 15,000(Rsclear) = 30,000 then we get partial refund 
        in other words we need to pay minimum half of total gas.
    */
    function case0Berlin()external payable {
        berlinVar1 = 0;
    }

    uint256 private berlinVar2 = 1;
    uint256 private berlinVar3 = 0;
    /*
    gas	              --->  72885 gas
    transaction cost  --->	33378 gas 
    execution cost	  --->  27314 gas

                setting !0 -> 0
        21,000  +   22,100   +   5,000   +  200    =   48,200 
                48,200      /  2      =   24,100  this much gas we are egligible for refund 
                48,200      -  15,000 =   33,200  but as per Yellow Paper max refund 15,000
    */
    function case1Berlin()external payable {
        berlinVar2 = 0;
        berlinVar3 = 1;
    }

    //CASE 1 
    uint256 private var1 = 1;
    /*
    EIP-3529 reduce gas refunds for EVM operation
        1. Remove the SELFDESTRUCT refund.
        2. Replace SSTORE_CLEARS_SCHEDULE (as define in EIP-2200) with 
            SSTORE_RESET_GAS + ACCESS_LIST_STORAGE_KEY_COST (4,800 gas of EIP-2929 + EIP-2930)
        3. Reduce the max gas refunded after a transaction to gas_used // MAX_REFUND_QUOTIENT
            notice: Previously max refunded was defined as gas_used // 2. 
                    Here we name the constant 2 as MAX_REFUND_QUOTENT and change its value to 5.

    gas	              --->  35648 gas
    transaction cost  --->	21398 gas 
    execution cost	  --->  5134 gas

                setting !0 -> 0
        21,000  +   5,000   +  200    =   26,200 
                26,200      -  4,800  =   21,400   total gas paid
                26,200      *  0.8    =   20,960
    */
    function case1()external  payable {
        var1 = 0;
    }

    //CASE 2
    uint256 private var2 = 1;
    uint256 private var3 = 1;
    /*
    gas	              --->  46985 gas
    transaction cost  --->	25005 gas 
    execution cost	  --->  10192 gas

                setting !0 -> 0
         21,000  +  5,000   x   2   +  200          =   31,200 
         31,200  -  4,800   x   2                   =   21,600 
        (21,000  +  5,000   x   2   +  200)  *  0.8 =   24,960
    */
    function case2()external payable{
        var2 = 0;
        var3 = 0;
    }

    //CASE 3
    uint256 private var4 = 1;
    uint256 private var5 = 1;
    uint256 private var6 = 1;
    /*
    gas	              --->  58195 gas
    transaction cost  --->	28964 gas 
    execution cost	  --->  15140 gas

                setting !0 -> 0
         21,000  +  5,000   x   3   +  200          =   36,200 
         36,200  -  4,800   x   3                   =   26,600 
        (21,000  +  5,000   x   3   +  200)  *  0.8 =   28,960
    */
    function case3()external payable {
        var4 = 0;
        var5 = 0;
        var6 = 0;
    }

    //CASE 4
    mapping(uint256 => uint256[])private var7;
    mapping(uint256 => uint256[])private var8;
    constructor(){
        var7[2] = [1,2,3];
        var8[2] = [1,2,3,4,5,6,7,8,9,10,11,12];
    }
    /*
    gas	              --->  70004 gas
    transaction cost  --->	33339 gas 
    execution cost	  --->  20609 gas

                setting !0 -> 0
         21,000  +  5,000   x   4   +  200          =   41,200 
         41,200  -  4,800   x   4                   =   22,000 
        (21,000  +  5,000   x   4   +  200)  *  0.8 =   32,960
    */
    function case4a()external payable {
        delete var7[2];
    }
    /*
    gas	              --->  171999 gas
    transaction cost  --->	69732 gas 
    execution cost	  --->  66100 gas

                setting !0 -> 0
         21,000  +  5,000   x  12   +  200          =   81,200 
         81,200  -  4,800   x  12                   =   23,600 
        (21,000  +  5,000   x  12   +  200)  *  0.8 =   64,960
    */
    function case4b()external payable {
        delete var8[2];
    }

    //CASE 5
    uint256 private var9 = 1;
    uint256 private var10 = 0;
    /*
    gas	              --->  61155 gas
    transaction cost  --->	43578 gas 
    execution cost	  --->  27314 gas

                setting !0 -> 0
         21,000  +  22,100  +  5,000   +  200                   =   48,300 
         48,300  -  4,800                                       =   43,500 
        (21,000  +  5,000   +   22,100  +  1   +  200)  *  0.8  =   38,640
    */
    function case5() external payable {
        var9 = 0;
        var10 = 1;
    }
    
    //CASE 6
    uint256 private var11 = 1;
    uint256 private var12 = 1;
    uint256 private var13 = 0;

    function case6()external payable {
        var11 = 0;
        var12 = 0;
        var13 = 1;
    } 

        //CASE 7
    uint256 private var14 = 1;
    uint256 private var15 = 1;

    function case7()external payable {
        var14 = 0;
        var15 = 2;

    } 

    //CASE 8
    // 0 -> 1 -> 2 -> 3 = 22,100 + 5,000 + 5,000 = 32,100
    // 3 -> 2 -> 1 -> 0 = 22,100 + 5,000 + 200   = 29,300
    
}