// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {FirstApplication} from "../src/FirstApplication.sol";


contract FirstApplicationTest is Test {

    FirstApplication public obj;

    function setUp() external {
        obj = new FirstApplication();
    }

    function test_has_magic_count_method() public view {
        assertEq(obj.count(), 0);
    }

    function test_initial_count_is_zero() public view {
        assertEq(obj.count(), 0);
    }

    function test_can_get() public view {
        assertEq(obj.get(), 0);
    }

    function test_can_increment() public {
        assertEq(obj.count(), 0);
        obj.inc();
        assertEq(obj.count(), 1);
    }

    function can_decrement() public {
        assertEq(obj.count(), 0);
        obj.inc();
        obj.inc();
        assertEq(obj.count(), 2);
        obj.dec();
        assertEq(obj.count(), 1);
    }

    function cannot_decrement_zero() public {
        assertEq(obj.count(), 0);
        vm.expectRevert();
        obj.dec();
    }
}