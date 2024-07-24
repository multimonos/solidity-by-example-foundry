// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {Order, Status} from "../src/EnumDeclaration.sol";

contract EnumDeclarationTest is Test {

    function test_default_value_for_unassigned() public pure {
        Status status;
        assertTrue(status == Status.Pending); // first value in Enum.Status
    }

    function test_assign() public pure {
        Status status = Status.Accepted;
        assertTrue(status == Status.Accepted);
    }

    function test_delete_resets_to_first_declared_value() public pure {
        Status status = Status.Rejected;
        assertTrue(status == Status.Rejected);
        delete status;
        assertTrue(status == Status.Pending);
    }

    function test_enum_as_contract_member() public {
        Order order = new Order();
        assertTrue(order.status() == Status.Pending);
    }
}

