// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ERC20Transfer is ERC20 {
    /*
        non-zero -> 0        | 0 -> non-zero         47,385
        non-zero -> non-zero | 0 -> non-zero         52,173
        non-zero -> non-zero | non-zero -> non-zero  35,073
        non-zero -> 0        | non-zero -> non-zero  30,285

        pender   : 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
        ecipient : 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
    */

    constructor() ERC20("Learning", "LR") {
        _mint(msg.sender, 100 ether);
    }
}

/*
        Storage cost For Files

        1kb = 1024
        32 words / kb

        |====================================================================================|
        |  kb   | words(32 bytes) | Gas per 32 bytes | Gas Price (gwei) | Eth Price |  USD   |
        |       |                 |    (0 -> !0)     |                  |           | TG*GP* |
        |       |                 | words * 22,100   |                  |           |   EP   |
        |====================================================================================|
        |   1   |       32        |    7,07,200      |      50          |   3000    | 106.08 |
        |====================================================================================|
    */

contract StructsStrings {
    struct MyStructsV1 {
        uint256 a;
        address b;
    }

    struct MyStructsV2 {
        uint256 a;
        address b;
        uint256 c;
    }

    struct MyStructsV3 {
        uint256 a;
        address b;
        string c;
    }

    MyStructsV1 myStructV1;
    MyStructsV2 myStructV2;
    MyStructsV3 myStructV3;

    /*
        gas	             -->  75469 gas
        transaction cost -->  65625 gas 
        execution cost	 -->  44561 gas 

          Tx        0 -> !0     0 -> !0  
        21,000  +   22,100  +   22,100  + Other Op code Cost    =  65625 
    */
    function setStructV1() external {
        myStructV1 = MyStructsV1({a: 5, b: msg.sender});
    }

    /*
        gas	             -->  32894 gas
        transaction cost -->  28603 gas 
        execution cost	 -->   7539 gas 

          Tx      !0 -> !0   coldStrg   warmAccess
        21,000  +   5,000  +   2,100   +   100  + Other Op code Cost    =  28603 
    */
    function setStructV2() external {
        myStructV1 = MyStructsV1({a: 6, b: msg.sender});
    }

    /*
        gas	             -->  100980 gas
        transaction cost -->   87808 gas 
        execution cost	 -->   66744 gas 

          Tx        0 -> !0     0 -> !0    0 -> !0 
        21,000  +   22,100  +   22,100  +   22,100  + Other Op code Cost    =  87808 
    */
    function setStructV3() external {
        myStructV2 = MyStructsV2({a: 5, b: msg.sender, c: 4});
    }

    /*
        gas	             -->  44182 gas
        transaction cost -->  28819 gas 
        execution cost	 -->  12555 gas 

          Tx       !0 -> !0   CS + WA      !0 -> 0 
        21,000  +   5,000  +   2,200  +   5000 - 4800  + Other Op code Cost    =  28819 
    */
    function setStructV4() external {
        myStructV2 = MyStructsV2({a: 6, b: msg.sender, c: 0});
    }

    /*
        gas	             -->  101688 gas
        transaction cost -->   88424 gas 
        execution cost	 -->   67360 gas 

          Tx        0 -> !0     0 -> !0    0 -> !0
        21,000  +   22,100  +   22,100  +   22,100  + Other Op code Cost    =  88424 
    */
    function setStructV5() external {
        myStructV3 = MyStructsV3({
            a: 5,
            b: msg.sender,
            c: "lorem ipsum dolor sit amet"
        });
    }

    /*
        gas	             -->  90527 gas
        transaction cost -->  78719 gas 
        execution cost	 -->  57655 gas 

        storage size jump acc to string size due to which we can also see the gas increase
    */
    function setStructV6() external {
        myStructV3 = MyStructsV3({
            a: 6,
            b: msg.sender,
            c: "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
            });
    }

    /*
        In case of boolean we use less slot only 2 variable slot because address is of 22bytes and 
        boolean will adjust in left bytes(32 - 22 = 10bytes).
    */

    function getCV1() external view returns (bytes32 val) {
        assembly {
            val := sload(add(myStructV1.slot, 1))
        }
    }

    function getCV2() external view returns (bytes32 val) {
        assembly {
            val := sload(add(myStructV2.slot, 2))
        }
    }

    function getCV3() external view returns (bytes32 val) {
        assembly {
            val := sload(add(myStructV3.slot, 2))
        }
    }
}
