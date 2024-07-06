// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";


contract TestMappings is Test {

    mapping(address => uint256) map;

    function test_set() public {
        map[address(2)] = 22;
        assertTrue(map[address(2)] == 22);
    }

    function test_delete() public {
        map[address(1)] = 111;
        map[address(2)] = 222;
        map[address(3)] = 333;

        assertTrue(map[address(2)] == 222);

        delete map[address(2)];

        assertTrue(map[address(2)] == 0);
    }
}

