// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {NestedMapping} from "../src/Mappings.sol";

contract MappingsNestedTest is Test {

    NestedMapping public nm;

    function setUp() external {
        nm = new NestedMapping();
    }

    /// @dev fuzzy
    function test_get_values_without_initializing(uint16 n) public view {
        assertFalse(nm.get(address(3), n));
        assertFalse(nm.get(address(2), n));
    }

    /// @dev fuzzy
    function test_set(uint8 n) public {
        address addr = makeAddr("somebody");
        assertFalse(nm.get(addr, n));
        nm.set(addr, n, true);
        assertTrue(nm.get(addr, n));
    }

    /// @dev fuzzy
    function test_remove(uint8 n) public {
        address addr = makeAddr("somebody");
        assertFalse(nm.get(addr, n));

        nm.set(addr, n, true);
        assertTrue(nm.get(addr, n));

        nm.remove(addr,n);
        assertFalse(nm.get(addr, n));
    }
}
