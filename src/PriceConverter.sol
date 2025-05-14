// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.19;
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getPrice(
        AggregatorV3Interface priceFeed
    ) internal view returns (uint256) {
        (, int256 price, , , ) = priceFeed.latestRoundData();
        return uint256(price * 1e18);
    }

    function getConversionRate(
        uint256 ethAmount,
        AggregatorV3Interface priceFeed
    ) internal view returns (uint256) {
        uint256 ethPrice = getPrice(priceFeed); //gets current price of eth in terms of usd eg 2k usd
        uint256 ethAmountInUSD = (ethPrice * ethAmount) / 1e18; // this will be 2k times eth amount
        return ethAmountInUSD;
    }

    /***function getConversionRateFromETH(uint256 ethAmount) internal  view returns (uint256){
       uint256 ethPrice = getPrice(); //gets current price of eth in terms of usd eg 2k usd
        return ((ethPrice * ethAmount)/1e18); // this will be 2k times eth amount
    }***/
}
