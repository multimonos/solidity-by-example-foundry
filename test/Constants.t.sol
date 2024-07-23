// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {Constants} from "../src/Constants.sol";

contract ConstantsTest is Test {

    Constants public obj;

    function setUp() external {
        obj = new Constants();
    }

    function test_my_address() public view {
        assertNotEq(obj.MY_ADDRESS(), address(0));
    }

    function test_my_uint() public view {
        assertTrue(obj.MY_UINT() >= type(uint).min);
        assertTrue(obj.MY_UINT() <= type(uint).max);
    }
}
