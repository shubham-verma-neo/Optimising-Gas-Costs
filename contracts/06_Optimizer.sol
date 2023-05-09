// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

    /*
    Optimizer
        - Deplyoment size of contract (Deploy Cost)
        - How expensive it will be to run a particular function after the contract is deploying 

    Without Optimizer
            - Bytes:    5791
        Trandfer Function 
            gas	                65570 gas
            transaction cost	47417 gas 
            execution cost	    30573 gas

    Optimizer - 200
            - Bytes:    3030
        Trandfer Function 
            gas	                64886 gas
            transaction cost	46822 gas 
            execution cost	    29978 gas

    Optimizer - 10000
            - Bytes:    3633
        Trandfer Function 
            gas	                64766 gas
            transaction cost	46718 gas 
            execution cost	    29874 gas

    Optimizer works for execution cost not for deploying cost. Increase the optimizer untill execution cost for 
        particular function stop decreasing. Ex. UniswapV3 Contract have 10,00,000
        
    0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
    100000000000000000000
    */

contract Optimizer is ERC20{
    constructor()ERC20("Testing", "TST"){
        _mint(msg.sender, 100 ether);
    }
}