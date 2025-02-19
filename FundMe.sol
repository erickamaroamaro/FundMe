// SPDX-License-Identifier:MIT

pragma solidity 0.8.19;

import {PriceConverter} from "./PriceConverter.sol";

error NotOwner();
contract FundMe {
    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 5e18;

    address[] public funders;
    mapping (address funder => uint256 amountFunded) public addressToAmountFunded;

    address public immutable i_owner;

    constructor(){
        i_owner = msg.sender;
    }

    // take a look at chainlink functions 
    function fund () payable public {
        require(msg.value.getConversionRate() >= MINIMUM_USD, "didn't send enoght eth");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
        // revert transaction if condition not true
    }

    function withdraw() public onlyOwner{
       
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }

        funders = new address[](0);
        //transfer
        //payable(msg.sender).transfer(address(this).balance);
        //send
        //bool sendSuccess = payable(msg.sender).send(address(this).balance);
        //require(sendSuccess, "Send fail");
        //call
        (bool callSuccess, ) = payable(msg.sender).call{value:address(this).balance}("");
        require(callSuccess, "call failed");
    }

    modifier onlyOwner(){
        if(msg.sender != i_owner) { revert NotOwner();}
         //require(msg.sender == i_owner,"Only owner can withdraw!");
         _; //runs the following code
    }

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }
}