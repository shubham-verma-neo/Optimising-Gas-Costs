// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

/* optimize=true&runs=1000 */

contract  StorageGasCost{

    /*
    Gas Cost
        - Setting storage 0 to non-zero         ---> 20,000
        - Setting storage non-zero to non-zero  --->  5,000
        - Setting storage non-zero to zero      ---> refund
        - Pay additional 2,100 gas if it is the first time accessing a variable in transaction 
        - Pay aditional 100 gas if it the variable has already been touched
        - Gtxcreate     ---> 32,000
        - Gtransaction  ---> 21,000
    */


    uint256 private myInteger;

    /*
    non-zero to non-zero

        gas	                30158 gas
        transaction cost	26224 gas 
        execution cost	    5160  gas 

        Total - Transaction = left(include coldsload & Op-code execution cost for any function call)
        26236 -   21000     = 5224

        (FORMULA FOR THIS IS IN YELLOW PAPER ON PAGE 34 - 0X55)

        Gsreset + Gcoldsload = Total
          2900  +  2100      = 5000
        
    Yellow Paper 
        page 34 
    */
    function setToOne()external {
        myInteger = 1;
    }

    /*
    zero to non-zero
        gas	                49799 gas
        transaction cost	43303 gas 
        execution cost	    22239 gas 
        
        Total - Transaction - 0 to non0 = left  - coldsload =   Op-code execution cost for any function call
        43303 -   21000     -   20000   = 2303  -   2100    =               203
    */
    function setToTwo()external{
        myInteger = 2;
    }

    function setToZero()external{
        myInteger = 0;
    }

    /*
    getting integer
        gas	                -- 
        transaction cost	--
        execution cost	    2291 gas 
        
        Total - Transaction = left  - coldsload =   Op-code execution cost for any function call
        23291 -   21000     = 2291  -   2100    =               191
    */
    function getInteger()external view returns(uint256){
        return myInteger;
    }
    /*
    get7set integer
        gas	                49894 gas 
        transaction cost	43386 gas
        execution cost	    22322 gas 
        
        Total - Transaction = left  - coldsload =   Op-code execution cost for any function call
        43386 -   21000     = 2291  -   2100    =               191
    */
    function getAndSetInteger()external {
        uint256 _myInteger = myInteger;
        myInteger = _myInteger + 1;
    }
    
    /*
    The point is that doing a storage read and then a storage write cost similar to only doing a storage write
        The read + write case is 
            2,100(Read + Cold Access) + 20,100(Write + Warm Access) = 22,200
        
        Doing a write without read is
                    20,000 + 2,100
                    Gsset + Gcoldsload 
            22,100 (Write + Cold Access)

        Cost(Reaad + Write) ~ Cost(Write)
    */

}