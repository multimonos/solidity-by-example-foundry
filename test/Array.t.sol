// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";

contract TestArrays is Test {

    uint256[] public a = [1, 2, 3]; // dynamic in storage only

    function test_delete_does_not_change_array_length() public pure {
        uint256[3] memory x = [uint256(1), 2, 3]; // only fixed size in memory
        assertTrue(x.length == 3);
        delete x[2];
        assertTrue(x.length == 3);
    }

    function test_pop_decreases_length() public {
        assertTrue(a.length == 3);
        a.pop();
        assertTrue(a.length == 2);
    }

    function test_push_increases_length() public {
        assertTrue(a.length == 3);
        a.push(4);
        assertTrue(a.length == 4);
    }

}

