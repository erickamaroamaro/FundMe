// SPDX-License-Identifier:MIT

pragma solidity 0.8.19;

import {PriceConverter} from "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;

    uint256 public minimumUsd = 5e18;

    address[] public funders;
    mapping (address funder => uint256 amountFunded) public addressToAmountFunded;

    // take a look at chainlink functions 
    function fund () payable public {
        require(msg.value.getConversionRate() >= minimumUsd, "didn't send enoght eth");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
        // revert transaction if condition not true
    }

    function withdraw() public {

        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
    }

}