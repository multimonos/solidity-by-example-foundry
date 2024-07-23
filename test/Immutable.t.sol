// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {Immutables} from "../src/Immutables.sol";


contract TestImmutables is Test {

    Immutables public obj;
    address public owner = makeAddr("owner");

    function setUp() public {
        vm.prank(owner);
        obj = new Immutables(42);
    }

    function test_immutable_uint() public view {
        assertTrue(obj.MY_UINT() == 42);
    }

    function test_address_is_sender() public view {
        assertEq(obj.MY_ADDRESS(), owner);
    }
}