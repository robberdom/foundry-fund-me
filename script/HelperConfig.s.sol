// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.19;

import {Script} from "./../lib/forge-std/src/Script.sol";
import {MockV3Aggregator} from "../test/mocks/MockV3Interface.sol";

contract HelperConfig is Script {
    NetworkConfig public activeNetworkConfig;

    uint8 public constant DECIMALS = 8;
    int256 public constant INITIAL_PRICE = 2000e8;

    struct NetworkConfig {
        address priceFeed;
    }

    constructor() {
        if (block.chainid == 11155111) {
            activeNetworkConfig = getSepliaETHConfig();
        } else if (block.chainid == 2021) {
            activeNetworkConfig = getRoninETHConfig();
        } else {
            activeNetworkConfig = getOrCreateAnvilETHConfig();
        }
    }

    function getSepliaETHConfig() public pure returns (NetworkConfig memory) {
        NetworkConfig memory sepoliaConfig = NetworkConfig({
            priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        });
        return sepoliaConfig;
    }

    function getRoninETHConfig() public pure returns (NetworkConfig memory) {
        NetworkConfig memory roninConfig = NetworkConfig({
            priceFeed: 0x798c8F5FF3dBa2B8CD95814936e1725c539d5C98
        });
        return roninConfig;
    }

    function getOrCreateAnvilETHConfig() public returns (NetworkConfig memory) {
        if (activeNetworkConfig.priceFeed != address(0)) {
            return activeNetworkConfig;
        }
        vm.startBroadcast();
        MockV3Aggregator mockPriceFeed = new MockV3Aggregator(
            DECIMALS,
            INITIAL_PRICE
        );
        vm.stopBroadcast();

        NetworkConfig memory anvilETHConfig = NetworkConfig({
            priceFeed: address(mockPriceFeed)
        });
        return anvilETHConfig;
    }
}
