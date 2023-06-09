// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract FunctionName{

    /*
    When we look at the actual op codes, what happens is solidity needs to check which function selector
    was included in transaction.data. 
    So first it checks was red picked,
        - and if so it's going to jump to execute red 
        - and then it's going to check was blue picked and if so, it's going to execute code for blue,
        - and lastly is going to check green picked and then it's going to jump to the code for green.
  
    The compiler will always sort will always sort these check in hexadecimal order.
        So 2 is smaller than E and E is smaller than F.

    There are 2 takeaways from thsis.
        - if you have a function that is very gas sensetive, you should try to make sure that its funciton
            selector is near the top. And remember, the function is the first four bytes of the keccak256 
            of the funciton name. when that function is formatted according to the specification.
        
        - other implication is that if you are bencjmarking a function to optimize it gas cost, to not change
            the name because you don't know that the changes are the result of the name funciton.

       FUNCTIONHASHES {
            "ed18f0a7": "blue()",
            "f2f1e132": "green()",
            "2930cf24": "red()"
        } 
    ASEMBLY {
        .code
        PUSH 80			contract FunctionName{\n\n    ...
        PUSH 40			contract FunctionName{\n\n    ...
        MSTORE 			contract FunctionName{\n\n    ...
        CALLVALUE 			contract FunctionName{\n\n    ...
        DUP1 			contract FunctionName{\n\n    ...
        ISZERO 			contract FunctionName{\n\n    ...
        PUSH [tag] 1			contract FunctionName{\n\n    ...
        JUMPI 			contract FunctionName{\n\n    ...
        PUSH 0			contract FunctionName{\n\n    ...
        DUP1 			contract FunctionName{\n\n    ...
        REVERT 			contract FunctionName{\n\n    ...
        tag 1			contract FunctionName{\n\n    ...
        JUMPDEST 			contract FunctionName{\n\n    ...
        POP 			contract FunctionName{\n\n    ...
        PUSH #[$] 0000000000000000000000000000000000000000000000000000000000000000			contract FunctionName{\n\n    ...
        DUP1 			contract FunctionName{\n\n    ...
        PUSH [$] 0000000000000000000000000000000000000000000000000000000000000000			contract FunctionName{\n\n    ...
        PUSH 0			contract FunctionName{\n\n    ...
        CODECOPY 			contract FunctionName{\n\n    ...
        PUSH 0			contract FunctionName{\n\n    ...
        RETURN 			contract FunctionName{\n\n    ...
        .data
        0:
            .code
            PUSH 80			contract FunctionName{\n\n    ...
            PUSH 40			contract FunctionName{\n\n    ...
            MSTORE 			contract FunctionName{\n\n    ...
            CALLVALUE 			contract FunctionName{\n\n    ...
            DUP1 			contract FunctionName{\n\n    ...
            ISZERO 			contract FunctionName{\n\n    ...
            PUSH [tag] 1			contract FunctionName{\n\n    ...
            JUMPI 			contract FunctionName{\n\n    ...
            PUSH 0			contract FunctionName{\n\n    ...
            DUP1 			contract FunctionName{\n\n    ...
            REVERT 			contract FunctionName{\n\n    ...
            tag 1			contract FunctionName{\n\n    ...
            JUMPDEST 			contract FunctionName{\n\n    ...
            POP 			contract FunctionName{\n\n    ...
            PUSH 4			contract FunctionName{\n\n    ...
            CALLDATASIZE 			contract FunctionName{\n\n    ...
            LT 			contract FunctionName{\n\n    ...
            PUSH [tag] 2			contract FunctionName{\n\n    ...
            JUMPI 			contract FunctionName{\n\n    ...
            PUSH 0			contract FunctionName{\n\n    ...
            CALLDATALOAD 			contract FunctionName{\n\n    ...
            PUSH E0			contract FunctionName{\n\n    ...
            SHR 			contract FunctionName{\n\n    ...
            DUP1 			contract FunctionName{\n\n    ...
            PUSH 2930CF24			contract FunctionName{\n\n    ...
            EQ 			contract FunctionName{\n\n    ...
            PUSH [tag] 3			contract FunctionName{\n\n    ...
            JUMPI 			contract FunctionName{\n\n    ...
            DUP1 			contract FunctionName{\n\n    ...
            PUSH ED18F0A7			contract FunctionName{\n\n    ...
            EQ 			contract FunctionName{\n\n    ...
            PUSH [tag] 4			contract FunctionName{\n\n    ...
            JUMPI 			contract FunctionName{\n\n    ...
            DUP1 			contract FunctionName{\n\n    ...
            PUSH F2F1E132			contract FunctionName{\n\n    ...
            EQ 			contract FunctionName{\n\n    ...
            PUSH [tag] 5			contract FunctionName{\n\n    ...
            JUMPI 			contract FunctionName{\n\n    ...
            tag 2			contract FunctionName{\n\n    ...
            JUMPDEST 			contract FunctionName{\n\n    ...
            PUSH 0			contract FunctionName{\n\n    ...
            DUP1 			contract FunctionName{\n\n    ...
            REVERT 			contract FunctionName{\n\n    ...
            tag 3			function red()external pure re...
            JUMPDEST 			function red()external pure re...
            PUSH [tag] 6			function red()external pure re...
            PUSH [tag] 7			function red()external pure re...
            JUMP 			function red()external pure re...
            tag 6			function red()external pure re...
            JUMPDEST 			function red()external pure re...
            PUSH 40			function red()external pure re...
            MLOAD 			function red()external pure re...
            PUSH [tag] 8			function red()external pure re...
            SWAP2 			function red()external pure re...
            SWAP1 			function red()external pure re...
            PUSH [tag] 9			function red()external pure re...
            JUMP 			function red()external pure re...
            tag 8			function red()external pure re...
            JUMPDEST 			function red()external pure re...
            PUSH 40			function red()external pure re...
            MLOAD 			function red()external pure re...
            DUP1 			function red()external pure re...
            SWAP2 			function red()external pure re...
            SUB 			function red()external pure re...
            SWAP1 			function red()external pure re...
            RETURN 			function red()external pure re...
            tag 4			function blue()external pure r...
            JUMPDEST 			function blue()external pure r...
            PUSH [tag] 10			function blue()external pure r...
            PUSH [tag] 11			function blue()external pure r...
            JUMP 			function blue()external pure r...
            tag 10			function blue()external pure r...
            JUMPDEST 			function blue()external pure r...
            PUSH 40			function blue()external pure r...
            MLOAD 			function blue()external pure r...
            PUSH [tag] 12			function blue()external pure r...
            SWAP2 			function blue()external pure r...
            SWAP1 			function blue()external pure r...
            PUSH [tag] 9			function blue()external pure r...
            JUMP 			function blue()external pure r...
            tag 12			function blue()external pure r...
            JUMPDEST 			function blue()external pure r...
            PUSH 40			function blue()external pure r...
            MLOAD 			function blue()external pure r...
            DUP1 			function blue()external pure r...
            SWAP2 			function blue()external pure r...
            SUB 			function blue()external pure r...
            SWAP1 			function blue()external pure r...
            RETURN 			function blue()external pure r...
            tag 5			function green()external pure ...
            JUMPDEST 			function green()external pure ...
            PUSH [tag] 13			function green()external pure ...
            PUSH [tag] 14			function green()external pure ...
            JUMP 			function green()external pure ...
            tag 13			function green()external pure ...
            JUMPDEST 			function green()external pure ...
            PUSH 40			function green()external pure ...
            MLOAD 			function green()external pure ...
            PUSH [tag] 15			function green()external pure ...
            SWAP2 			function green()external pure ...
            SWAP1 			function green()external pure ...
            PUSH [tag] 9			function green()external pure ...
            JUMP 			function green()external pure ...
            tag 15			function green()external pure ...
            JUMPDEST 			function green()external pure ...
            PUSH 40			function green()external pure ...
            MLOAD 			function green()external pure ...
            DUP1 			function green()external pure ...
            SWAP2 			function green()external pure ...
            SUB 			function green()external pure ...
            SWAP1 			function green()external pure ...
            RETURN 			function green()external pure ...
            tag 7			function red()external pure re...
            JUMPDEST 			function red()external pure re...
            PUSH 0			uint256
            PUSH 1			1
            SWAP1 			return 1
            POP 			return 1
            SWAP1 			function red()external pure re...
            JUMP 			function red()external pure re...
            tag 11			function blue()external pure r...
            JUMPDEST 			function blue()external pure r...
            PUSH 0			uint256
            PUSH 1			1
            SWAP1 			return 1
            POP 			return 1
            SWAP1 			function blue()external pure r...
            JUMP 			function blue()external pure r...
            tag 14			function green()external pure ...
            JUMPDEST 			function green()external pure ...
            PUSH 0			uint256
            PUSH 1			1
            SWAP1 			return 1
            POP 			return 1
            SWAP1 			function green()external pure ...
            JUMP 			function green()external pure ...
            tag 19			-License-Identifier: MIT\nprag...
            JUMPDEST 			-License-Identifier: MIT\nprag...
            PUSH 0			ity ^0.
            DUP2 			onNam
            SWAP1 			ract FunctionNam
            POP 			ract FunctionNam
            SWAP2 			-License-Identifier: MIT\nprag...
            SWAP1 			-License-Identifier: MIT\nprag...
            POP 			-License-Identifier: MIT\nprag...
            JUMP 			-License-Identifier: MIT\nprag...
            tag 20			      FUNCTIONHASHES {\n      ...
            JUMPDEST 			      FUNCTIONHASHES {\n      ...
            PUSH [tag] 24			()",\n            "2930cf
            DUP2 			2930c
            PUSH [tag] 19			()",\n            "2930cf
            JUMP 			()",\n            "2930cf
            tag 24			()",\n            "2930cf
            JUMPDEST 			()",\n            "2930cf
            DUP3 			gre
            MSTORE 			132": "green()",\n            ...
            POP 			      FUNCTIONHASHES {\n      ...
            POP 			      FUNCTIONHASHES {\n      ...
            JUMP 			      FUNCTIONHASHES {\n      ...
            tag 9			        } \n\n        \n    x/...
            JUMPDEST 			        } \n\n        \n    x/...
            PUSH 0			)ext
            PUSH 20			  
            DUP3 			256){\n   
            ADD 			uint256){\n        
            SWAP1 			returns(uint256){\n        
            POP 			returns(uint256){\n        
            PUSH [tag] 26			    }\n\n    /*\n        execu...
            PUSH 0			(
            DUP4 			unction r
            ADD 			   function red()
            DUP5 			\n    *
            PUSH [tag] 20			    }\n\n    /*\n        execu...
            JUMP 			    }\n\n    /*\n        execu...
            tag 26			    }\n\n    /*\n        execu...
            JUMPDEST 			    }\n\n    /*\n        execu...
            SWAP3 			        } \n\n        \n    x/...
            SWAP2 			        } \n\n        \n    x/...
            POP 			        } \n\n        \n    x/...
            POP 			        } \n\n        \n    x/...
            JUMP 			        } \n\n        \n    x/...
            .data
        }
    
    if we check closely then in each function it increase by 22 gas 
        PUSH FUNCTIONHASHES  ---> 03
        EQ                   ---> 03
        PUSH [tag] 3         ---> 03
        JUMPI                ---> 10
        DUP1                 ---> 03
                     Total    =   22
    
    */

    /*
        execution cost	310 gas
    */
    function red()external pure returns(uint256){
        return 1;
    }

    /*
        execution cost	332 gas
    */
    function blue()external pure returns(uint256){
        return 1;
    }

    /*
        execution cost	354 gas
    */
    function green()external pure returns(uint256){
        return 1;
    }
}
