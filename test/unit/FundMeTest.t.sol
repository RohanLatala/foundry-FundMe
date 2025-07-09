//SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;
//import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/tests/MockV3Aggregator.sol";

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    FundMe fundMe;

    function setUp() external {
        //fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
    }

    function testMinimumDollarIsFive() public view {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testOwnerIsmsgSender() public view {
        // assrertEq(fundMe.i_owner(), msg.sender);  wrong because owner now is not msg sender, we changed it to FundMeTest not us (in this test file only)
        assertEq(fundMe.i_owner(), msg.sender);
    }

    function testFundFailsWithoutEnoughETH() public {
        vm.expectRevert(); //hey, the next line ,should revert
        // == assert(this tx fails/reverts)
        fundMe.fund();
    }
}
