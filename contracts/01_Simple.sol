// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract Simple{
    uint256 private x = 10;

    /* execution cost	2351 gas */
    function light()external  view returns(uint256){
        return x + 1;
    }

    /* execution cost	20650 gas */
    function heavy50Loops()external view returns(uint256){
        bytes32 _x = keccak256(abi.encodePacked(x));
        for(uint256 i = 0; i < 50; i++){
            _x = keccak256(abi.encodePacked(x));
        }
        return uint256(_x);
    }

    /* execution cost	11581 gas */
    function heavy25Loops()external view returns(uint256){
        bytes32 _x = keccak256(abi.encodePacked(x));
        for(uint256 i = 0; i < 25; i++){
            _x = keccak256(abi.encodePacked(x));
        }
        return uint256(_x);
    }
}
