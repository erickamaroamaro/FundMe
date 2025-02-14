//// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

contract FundMe {

    function fund () public payable  {
        // allow user to send money
        // Have a minimum to send
        require(msg.value > 1e18, "didn't send enought eth");
    }

    function withdraw() public {

    }


}