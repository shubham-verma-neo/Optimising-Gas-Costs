// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Precompute {
    function mul() external pure returns (uint256) {
        return 3 * 7; // hex 15
    }

    function div() external pure returns (uint256) {
        return 22 / 2; // hex b
    }

    function divUnoptimized() external pure returns (uint256) {
        uint256 a = 2;
        return 22 / a; // hex b
    }

    function functionSignatureOptimized() external pure returns (bytes4) {
        return bytes4(keccak256("withdraw()"));
    }

    function hashNotOptimized() external pure returns (bytes32) {
        return keccak256(abi.encodePacked(uint256(2 + 3)));
    }

    function signatureTest() external pure returns (bytes4) {
        string memory functionName = "withdraw()";
        bytes32 functionHash = keccak256(abi.encodePacked(functionName));
        return bytes4(functionHash);
    }

    function exponent(uint256 i) external pure returns (uint256) {
        return 2**(3 - 1) * uint256(0x000007) * i;
    }

    function multistepNotOptimized() external pure returns (uint256) {
        uint256 y = 2 - 1;
        return 2**y;
    }
}
