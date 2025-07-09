//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;
import {Script} from "forge-std/Script.sol";
import {MockV3Aggregator} from "../test/mocks/MockV3Aggregator.sol";

contract HelperConfig is Script {
    //if we are on a local anvil , we deploy mocks
    //otherwise , grab the existing address from the live network

    // function getActiveNetworkConfig()
    //  public
    //view
    //returns (NetworkConfig memory)
    //{
    //  return activeNetworkConfig;
    //}

    NetworkConfig public activeNetworkConfig;
    // created to configure between the active network between sepolia or anvil etc
    // in deployme.sol point towrds the network to be used
    uint8 public constant DECIMALS = 8;
    int256 public constant INITIAL_PRICE = 2000e8;

    struct NetworkConfig {
        //(not be used for anvil )struct NetworkConfig
        address priceFeed;
    }

    constructor() {
        if (block.chainid == 11155111) {
            activeNetworkConfig = getSepoliaEthConfig();
        } else {
            activeNetworkConfig = getAnvilEthConfig();
        }
    }

    function getSepoliaEthConfig() public pure returns (NetworkConfig memory) {
        NetworkConfig memory sepoliaConfig = NetworkConfig({
            priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        });
        return sepoliaConfig;
    }

    function getAnvilEthConfig() public returns (NetworkConfig memory) {
        if (activeNetworkConfig.priceFeed != address(0)) {
            return activeNetworkConfig;
        }
        vm.startBroadcast();
        //we will deploy here our own price feed
        //so we need our own price feed contract
        MockV3Aggregator mockPriceFeed = new MockV3Aggregator(
            DECIMALS,
            INITIAL_PRICE
        );
        vm.stopBroadcast();

        NetworkConfig memory anvilConfig = NetworkConfig({
            priceFeed: address(mockPriceFeed)
        });
        // activeNetworkConfig = anvilConfig;
        return anvilConfig;
    }

    //deploy the mocks
    //return the mock address
    // vm will be used , so no pure
    // helper config is script
}
