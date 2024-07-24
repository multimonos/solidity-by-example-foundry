// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";

contract TestArrays is Test {

    uint256[] public a = [1, 2, 3]; // dynamic literal assign in storage only

    function test_create_init_zero() public pure {
        uint[3] memory x;
        assertTrue(x[0] == 0);
        assertTrue(x[1] == 0);
        assertTrue(x[2] == 0);
    }

    function test_create_alt() public pure {
       uint256[] memory x = new uint256[](3);
        assertTrue(x[0] == 0);
        assertTrue(x[1] == 0);
        assertTrue(x[2] == 0);
    }

    function test_delete_does_not_change_array_length() public pure {
        uint256[3] memory x = [uint256(1), 2, 3]; // only fixed size in memory
        assertTrue(x.length == 3);
        delete x[0];
        delete x[1];
        delete x[2];
        assertTrue(x.length == 3);
    }

    function test_storage_length() public view {
        assertEq(a.length, 3);
    }

    function test_storage_pop_decreases_length() public {
        assertTrue(a.length == 3);
        a.pop();
        assertTrue(a.length == 2);
    }

    function test_storage_push_increases_length() public {
        assertTrue(a.length == 3);
        a.push(4);
        assertTrue(a.length == 4);
    }

}

