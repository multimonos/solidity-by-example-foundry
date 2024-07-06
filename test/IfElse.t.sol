// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";

contract TestIfElse is Test {

    function test_if_true() public pure {
        uint x = 0;
        if (true) {
            x = 3;
        }
        assertTrue(x == 3);
    }

    function test_if_false() public pure {
        uint x = 0;
        if (false) {
            x = 3;
        }
        assertTrue(x == 0);
    }

    function test_if_true_else() public pure {
        uint x = 0;
        if (true) {
            x = 5;
        } else {
            x = 7;
        }
        assertTrue(x == 5);
    }

    function test_if_false_else() public pure {
        uint x = 0;
        if (false) {
            x = 5;
        } else {
            x = 7;
        }
        assertTrue(x == 7);
    }

    function test_ternary_true() public pure {
        uint x = 0;
        x = true ? 5 : 7;
        assertTrue(x == 5);
    }

    function test_ternary_false() public pure {
        uint x = 0;
        x = false ? 5 : 7;
        assertTrue(x == 7);
    }
}
