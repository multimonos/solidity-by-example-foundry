// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {SimpleStorage} from "../src/ReadAndWriteState.sol";


contract SimpleStorageTest is Test {

    SimpleStorage public x;

    function setUp() public {
        x = new SimpleStorage();
    }

    function test_get() public view {
        assertTrue(x.get() == 0);
    }

    function test_set() public {
        x.set(42);
        assertTrue(x.get() == 42);
    }
}