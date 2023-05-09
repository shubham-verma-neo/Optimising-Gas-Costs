// SPDX-License-Identifier: MIT

/*
    Block Limits

    - Bitcoin historically has limited the block size to 1MB.
    - Ethereum does not explicity set a byte limit to the block size.
    - Instead, ethereum limits the amount of computations per block, or gas.
    - Each computation has a gas cost as noted earlier.
    - If a block has too much computation on it, it will be difficult for nodes to 
        verify the transaction quickly.
    - At the time of recording, the block limit is 30 million gas.
    - An eth transfer costs 21,000 gas, so theoretically one block can hold 1,428 transfer.
    - On the other extreme, if everyone is using tarnado cash, which costs almost a million gas per transaction,
        only transfer will fit.

    Throughput 

    - A new block is genrated every 15seconds
    - The transaction throughput will be between 2 and 95 transaction per second (tps)
    - Ethereum has been doing on average 13 tps at the time of recording

    Implications

    - There cannot be more than 1428 transfer on one block. If more than 1428 person trying to make a transfer,
        then the highest bidder will have their transaction included on the block. This is why gas price 
        fluctuate.
    - 21,000 is isilation might seems like an arbitary number, but you can conceretely think of it as being 0.07%
        of Ethereum's computational capacity per 15 seconds.
    - If your smart contract requies over the 30 million gas to execute, it won't fit on the block.
    - If more smart contract engineers took this course, the more transactions would fit on the block, and ethereum 
        would have a better throughput because more transacrtions would fit on the block.
    - Your design decisions as an engineer don't just affect your users, they affect other ethereum users.

    Important 

    - 30 M is not the hard limit. The gas limit changes and is not completely static.
    - Ethereum technically has prefered block limit and dynamic block limit but conceptually, you can just 
        think of it as 30 M gas.
    - A future fork may change this number.
    
    Summary

    - On deplyoment. The smaller the smart contract, the less gas you pay on deployment.
    - During computation. Using fewer or cheaper op-codes saves gas on execution.
    - Transaction data. The larger your transaction data, and the more non-zero bytes you have in it,
        the more gas it cost.
    - Memory. The more mermory you allocate, even if you don't use it, you more gas.    
*/

pragma solidity ^0.8.0;

contract Storage{
    uint256 a = 3;
    uint256 x = 9;
    uint256 y = 1;
    
    /*

    PUSH 0  (0 is storage location of a)
    LOAD
    PUSH 1
    ADD     (it only look 2 items inside of stack if there are not 2 items ADD will not work)

    */
    function aPlusOne()external view returns(uint256){
        return a + 1;
    }

    /*

    PUSH 5
    PUSH 1
    LOAD
    PUSH 3
    PUSH 2
    LOAD
    MUL
    SWAP 2
    MUL
    ADD

    */
    function complex()external view returns(uint256){
        return (5 * x + 3 * y);
    }

    /*
        https://ethereum.github.io/yellowpaper/paper.pdf
        https://ethereum.org/en/developers/docs/evm/opcodes/
    */
}