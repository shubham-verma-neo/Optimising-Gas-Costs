// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract ShortCircuit{
    bool publicMint = true;
    mapping (address => bool)public allowed;
    function addToAllowed(address _address)external {
        // THIS CODE DOESN'T HAVE ACCESS CONTROLS. DO NOT USE IN PRODUCTION
        allowed[_address] = true;
    }
    /*
        X || Y

        in this, orders matters in below require condition first condition is block.timestamp and
        second is allowed mapping. in reading block.timestamp it only require 2 gas as per YELLOW PAPER
        on other hand reading from cold storage (allowed mapping) it requires 2,100 gas so it is better to
        put less gas consuming condition first.
    */
    function shortCircuit() external {
        require(block.timestamp > 1685447295 || allowed[msg.sender], "invalid" );
    }
}