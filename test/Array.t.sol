// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {Arrays} from "../src/Arrays.sol";

contract ArraysTest is Test {

    Arrays public con;

    uint256[] public a = [1, 2, 3]; // dynamic literal assign in storage only

    function setUp() external {

        con = new Arrays();

        address[] memory users = new address[](5);
        users[0] = makeAddr('one');
        users[1] = makeAddr('two');
        users[2] = makeAddr('three');
        users[3] = makeAddr('four');
        users[4] = makeAddr('five');
        con.addUsers(users);
    }

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

    function test_get_storage_arr_length() public view {
        // public[] does not have accessible .length prop
        assertEq(con.getUserCount(), 5);
    }

    function test_get_storage_arr_values() public view {
        // public[] does not return values array
        address[] memory users = con.getUsers();
        assertEq(users.length, 5);
    }

    function test_get_storage_arr_item() public {
        //public[] does provide item accessor
        address one = con.users(0);
        assertEq(one, makeAddr('one'));
        address two = con.users(1);
        assertEq(two, makeAddr('two'));
    }
}

