// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract VariablePackingV1 {
    /*
        it actually takes more work in execution if you are using a interger that is less than uint256.
        so it actually costs more gas to use a uint128 or smaller compare to uint256.
    */
    uint128 private a1 = 1;
    uint128 private b1 = 2;

    /*
        execution cost	2561 gas
    */
    function getSlotAuint128() external pure returns (uint256 value) {
        assembly {
            value := a1.slot
        }
    }

    /*
        execution cost	2569 gas
    */
    function getSlotBuint128() external pure returns (uint256 value) {
        assembly {
            value := b1.slot
        }
    }

    function loadSlot0uint128() external view returns (bytes32 value) {
        assembly {
            value := sload(0)
        }
    }

    function getAuint128() external view returns (uint128) {
        return a1;
    }

    function getBuint128() external view returns (uint128) {
        return b1;
    }

    /*
        .slot give us storage location 
        .offset give us the location within the storage location 
    */
    function getOffsetAuint128() external pure returns (uint256 a1Offset) {
        assembly {
            a1Offset := a1.offset
        }
    }

    function getOffsetBuint128() external pure returns (uint256 b1Offset) {
        assembly {
            b1Offset := b1.offset
        }
    }

    function getSlotAuint256() external pure returns (uint256 value) {
        assembly {
            value := a2.slot
        }
    }

    uint256 private a2 = 1;
    uint256 private b2 = 2;

    /*
        execution cost	2521 gas
    */
    function getSlotBuint256() external pure returns (uint256 value) {
        assembly {
            value := b2.slot
        }
    }

    /*
        execution cost	2433 gas
    */
    function getAuint256() external view returns (uint256) {
        return a2;
    }

    function getBuint256() external view returns (uint256) {
        return b2;
    }

    function getOffsetAuint256() external pure returns (uint256 a2Offset) {
        assembly {
            a2Offset := a2.offset
        }
    }

    function getOffsetBuint256() external pure returns (uint256 b2Offset) {
        assembly {
            b2Offset := b2.offset
        }
    }
}

/*
        - We see that it is clearly more expensive to use uint128 than a regular uint256 and that's because it 
            has to do all that extra masking opertation.
        - So if that is the case, why would you ever use something less than uint256 bits if it is less
            efficient ?
            If we knew that we were going to be writing both of these variable in the same 
                transaction, then it would make sense to pack them.
    */

contract VariablePackingV2 {
    struct StakeV1 {
        uint128 amount;
        uint128 stakeTimeStamp;
    }

    struct StakeV2 {
        uint256 amount;
        uint256 stakeTimeStamp;
    }

    mapping(address => StakeV1) stakeInfoV1;
    mapping(address => StakeV2) stakeInfoV2;

    /*
        gas	             ---> 50467 gas
        transaction cost ---> 43884 gas 
        execution cost	 ---> 22820 gas

          Tx        0 -> !0
        21,000  +   22,100  +  Other Op code Cost  =  43884

        it used only one slot charge 32bytes even though we are writing in 2 variable.
    */
    function setStake128() external {
        stakeInfoV1[msg.sender] = StakeV1({
            amount: 10,
            stakeTimeStamp: uint128(block.timestamp)
        });
    }

    /*
        gas	             ---> 75417 gas
        transaction cost ---> 65580 gas 
        execution cost	 ---> 44516 gas

          Tx       0 -> !0     0 -> !0
        21,000  +   22,100  +   22,100  +  Other Op code Cost  =  65580

        it used 2 slot charge 32bytes.
    */
    function setStake256() external {
        stakeInfoV2[msg.sender] = StakeV2({
            amount: 10,
            stakeTimeStamp: uint256(block.timestamp)
        });
    }
}
