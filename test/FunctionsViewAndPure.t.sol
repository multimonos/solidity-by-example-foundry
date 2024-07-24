// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {FunctionsViewAndPure} from "../src/FunctionsViewAndPure.sol";

contract FunctionsViewAndPureTest is Test {

    function test_view_promises_not_to_modify_state() public {
        FunctionsViewAndPure fns = new FunctionsViewAndPure();
        uint256 value = fns.addToX(3);
        assertTrue(fns.x() == 1);
        assertTrue(value == 4);
    }

    function test_pure_promises_not_to_modify_or_read_state() public {
        FunctionsViewAndPure fns = new FunctionsViewAndPure();
        uint256 value = fns.add(3, 5);
        assertTrue(value == 8);
    }
}
