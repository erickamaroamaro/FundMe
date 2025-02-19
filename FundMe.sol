// SPDX-License-Identifier:MIT

pragma solidity 0.8.19;

interface AggregatorV3Interface {
  function decimals() external view returns (uint8);

  function description() external view returns (string memory);

  function version() external view returns (uint256);

  function getRoundData(
    uint80 _roundId
  ) external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);

  function latestRoundData()
    external
    view
    returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);
}
contract FundMe {

    uint256 public minimumUsd = 5;
    // take a look at chainlink functions 
    function fund () payable public {
        // allowing user to send money
        // a mininum is required to send 
        require(msg.value >= minimumUsd, "didn't send enoght eth");
        // revert transaction if condition not true
    }

    function getPrice() public {
        // address 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419
        // ABI 
    }
    function getConversionRate() public {}

    function getVersion() public view returns (uint256){
        return AggregatorV3Interface(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419).version();
    }
}