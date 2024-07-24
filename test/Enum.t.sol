// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {Order} from"../src/Enum.sol";

contract OrderTest is Test {

    Order public obj;

    function setUp() external {
        obj = new Order();
    }

    function test_default_value_for_unassigned() public pure {
        Order.Status status;
        assertTrue(status == Order.Status.Pending); // first value in Order.Status
    }

    function test_get() public view {
        assertTrue(obj.get() == Order.Status.Pending); // first value in Order.Status
    }

    function test_set() public {
        obj.set(Order.Status.Accepted);
        assertTrue(obj.get() == Order.Status.Accepted);
    }

    function test_delete_resets_to_first_enum_value() public {
        obj.set(Order.Status.Accepted);
        obj.reset();
        assertTrue(obj.get() == Order.Status.Pending); // first value in Order.Status
    }
}
