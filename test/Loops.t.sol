// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {Loop} from "../src/Loop.sol";

contract LoopsTest is Test {

    Loop public obj;

    function setUp() external {
        obj = new Loop();
    }

    function test_loop() public {
        assertTrue(obj.loop() == 10);
    }

    function test_for_loop() public pure {
        uint n = 0;
        for (uint i = 0; i < 5; i++) {
            n = i;
        }
        assertTrue(n == 4);
    }

    function test_while_loop() public pure {
        uint n = 0;
        uint i = 0;
        while (i < 5) {
            n = i;
            i++;
        }
        assertTrue(n == 4);
    }

    function test_do_while() public pure {
        uint n = 0;
        uint i = 0;

        do {
            n = i;
            i++;
        } while (i < 5);

        assertTrue(n == 4);
    }
}

