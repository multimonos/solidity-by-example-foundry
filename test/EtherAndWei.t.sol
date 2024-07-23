// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {EtherAndWei} from "../src/EtherAndWei.sol";


contract EtherAndWeiTest is Test {

    EtherAndWei public obj;

    function setUp() external {
        obj = new EtherAndWei();
    }

    function test_one_wei_is_1() public view {
        assertTrue(obj.oneWei() == 1);
    }

    function test_one_gwei() public view {
        assertTrue(obj.oneGwei() == 1e9);
    }

    function test_one_ether() public view {
        assertTrue(obj.oneEther() == 1e18);
    }
}