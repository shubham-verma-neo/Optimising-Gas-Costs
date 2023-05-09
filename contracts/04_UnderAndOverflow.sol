// SPDX-License-Identifier: MIT
// pragma solidity 0.7.6;
pragma solidity 0.8.0;

contract UnderAndOverflow {
    uint8 myNumber = 100;

    // 1 0000 0000
    function add156() external view returns (uint8) {
        return myNumber + 156;
    }

    function subtract101() external view returns (uint8) {
        return myNumber - 101;
    }
}

contract UnderAndOverflow8plus {
    uint8 myNumber = 100;

    function add156() external view returns (uint8) {
        return myNumber + 156;
    }

    function subtract101() external view returns (uint8) {
        return myNumber - 101;
    }
}

contract UnderAndOverflowUnchecked {
    uint8 public myNumber = 0;

    /*
    gas	                50292 gas
    transaction cost	43732 gas 
    execution cost  	22668 gas
    */
    function increment() external {
        myNumber++;
    }

    /*
    gas	                36097 gas
    transaction cost	21788 gas 
    execution cost	    5524 gas 
    */
    function decrement() external {
        myNumber--;
    }

    /*
    gas	                50043 gas
    transaction cost	43515 gas 
    execution cost	    22451 gas 
    */
    function uncheckedIncrement() external {
        unchecked {
            myNumber++;
        }
    }

    /*
    gas	                35977 gas
    transaction cost	21684 gas 
    execution cost	    5420 gas
    */
    function uncheckedDecrement() external {
        unchecked {
            myNumber--;
        }
    }
}
