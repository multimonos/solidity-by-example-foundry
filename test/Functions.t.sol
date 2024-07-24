// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {Functions} from "../src/Functions.sol";


contract FunctionsTest is Test {

    Functions f;

    function setUp() public {
        f = new Functions();
    }

    function test_return_many() public view {
        (uint256 x, bool y, uint256 z) = f.returnMany();
        assertTrue(x == 1);
        assertTrue(y == true);
        assertTrue(z == 2);
    }

    function test_return_many_named() public view {
        (uint256 x, bool y, uint256 z) = f.returnManyNamed();
        // return names are irrelevant, documentation only
        assertTrue(x == 1);
        assertTrue(y == true);
        assertTrue(z == 2);
    }

    function test_named_return_values_do_not_require_return_keyword() public view {
        // yikes!!!
        (uint256 x, bool y, uint256 z) = f.impliedReturn();
        assertTrue(x == 1);
        assertTrue(y == true);
        assertTrue(z == 2);
    }

    function test_return_array() public view {
        uint256[] memory a = f.canReturnArray();
        assertTrue(a.length == 3);
    }

    function test_consume_array() public view {
        uint256[2] memory a = [uint256(11), 22];
        uint256[2] memory b = f.consumeArray(a);

        assertTrue(a[0] == 11);
        assertTrue(a[1] == 22);
        assertTrue(b[0] == 1100);
        assertTrue(b[1] == 2200);
    }

    function test_call_named() public view {
        bool w = false;
        bool rs = f.hasManyInputs({
            v: 12,
            w: w,
            x: 4565,
            z: address(3),
            y: "foobar"
        });
        assertTrue(rs);
    }
}

