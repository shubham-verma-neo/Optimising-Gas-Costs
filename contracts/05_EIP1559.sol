// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EIP1559{
    /*
    EIP 1559 is confusing!
        - Max Base Fee
        - Base Fee
        - Max Fee
        - Priority Fee

        Gas price per gwei <= max_fee

    The EIP 1559 has only two fees and one global variable
        - max_priority_fee_per_gas
        - max_fee_per_gas (max base fee in metamask)
        - max_fee_per_gas is the most gwei per gas you are willing to pay 
        - max_priority_fee_gas is what portion of that max_per_gas you want to be a miner tip
        - There is also a protocol-level BASEFEE 

    BASEFEE
        - BASEFEE all caps is the protocol-level base fee
        - This is visible on every block
        - BASEFEE burned
        - VERY ROUGHLY it is increases by 12% if the last block was full and decreases by 12% if the last
            block was empty
        - Exactformula is complicated -> https://eips.ethereum.org/EIPS/eip-1559
        - Solidity ^0.8.7 block.basefee 

    Max Base Fee
        - For a transaction to go through, max_fee >= BASEFEE
        - Because  BASEFEE can fluctuate, the protocol BASEFEE might exceed the basefee you paid when
            you signed your transaction 
        - So you don't specify a basefee, you specify how high a basefee you are willing to pay at most.
            If the next block increases the BASEFEE because the previous block was full, you want
            your max fee to cover this contigency.

        Priority Fee
            - max_priority_fee = max priority fee you specify in the transaction
            - priority fee = amount miner actually receives. Also known as Miner tip

            - max fee - BASEFEE = leftover
            5 - 3 = 2 - 1.5 = 0.5
            5 - 4 = 1 - 1.0 = 0
            case1: max_priority_fee < letover: leftover - max_priority_fee = refund
            case2: max_priority_fee >= leftover: refund = 0 , miner gets leftover
            if max_priority_fee > leftover --> refund = 0
                tx fee = BASEFEE + (max_fee - max_priority_fee)
                tx fee = BASEFEE + miner tip
            if max_priority_fee < leftover --> refund = 0
                tx fee = burned fee (basefee) + max_priority_fee
        max_priority_fee + BASEFEE < max_fee_per_gas 

            ----------------------------------                      -
            |                                |                      |
            |           Refund               |                      |
            |                                |                      |
            ----------------------------------      -               |max_fee_per_gas
            |Priority Fee = max_priority_fee |      |               |
            ----------------------------------      | gasPrice      |
            |BASEFEE                         |      |               |
            ----------------------------------      -               -


        BASEFEE + max_priority_fee > max_fee_per_gas

            ----------------------------------  -
            |amount miner does not receive   |  |
            ----------------------------------  |   max_priority_fee    -
            |Priority fee, miner tip         |  |                       |
            ----------------------------------  -                       |   max_fee_per_gas = gasPrice
            |BASEFEE                         |                          |
            ----------------------------------                          -

        Example 0
            - BASEFEE is X
            - max_fee_per_gas = 90 
            - max_priority_fee_per_gas = 100
            - This is invalid because max_priority_fee_per_gas
        Example 1
            - BASEFREE is zero
            - max_fee_per_gas = 3
            - max_priority_fee_per_gas = 3
            - you pay 3 gwei per gas
            - The miner receives 3 gwei per gas
            - No ether is burned
        Example 2a
            - BASEFREE is 70
            - max_fee_per_gas = 90
            - max_priority_fee_per_gas = 50
            - 70 gwei per gas is burned
            - 20 gwei per gas goes to the miner
            - the miner can't receive 50 gwei per gas unless the BASEFEE had dropped to 40 
        Example 2b
            - BASEFREE is 70
            - max_fee_per_gas = 90
            - max_priority_fee_per_gas = 15
            - 70 gwei per gas is burned
            - 15 gwei per gas goes to the miner
            - 5 gwei is refunded
        Example 3
            - BASEFEE is 90
            - max_fee_per_gas = 90
            - max_priority_fee_per_gas = 90
            - Miner will probably not accept this transaction because it contains no tip
    
    Conclusion 
        - BASEFEE = amount burned. This is determined by the network
        - Max Fee = most you are willing to pay fot the transaction independent of the priority fee.
            This is upper bound of the gas price your transaction will pay
        - Max Priority Fee = the most you are willing to give to the miner
        - Miner Tip / Priority Tip = The amount the miner actually receives. The miner will receive less than 
            the max priority fee if max_fee - BASEFEE < max_priority_fee
    */
}