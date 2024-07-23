// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {BasicMapping} from "../src/Mappings.sol";


contract MappingsTest is Test {

    mapping(address => uint256) public  map;

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

        assertTrue(map[address(1)] == 111);
        assertTrue(map[address(2)] == 0);
        assertTrue(map[address(3)] == 333);
    }

    function test_contract_get() public {
        BasicMapping bm = new BasicMapping();
        bm.set(address(2), 222);
        bm.set(address(3), 333);
        assertEq(bm.get(address(2)), 222);
        assertEq(bm.get(address(3)), 333);
    }

    function test_contract_set() public {
        BasicMapping bm = new BasicMapping();
        bm.set(address(3), 333);
        assertEq(bm.get(address(3)), 333);
        assertEq(bm.myMap(address(3)), 333);
    }

    function test_contract_remove() public {
        BasicMapping bm = new BasicMapping();
        bm.set(address(2), 222);
        bm.set(address(3), 333);
        assertEq(bm.get(address(3)), 333);
        assertEq(bm.get(address(2)), 222);

        bm.remove(address(2));

        assertEq(bm.get(address(2)), 0);
        assertEq(bm.get(address(3)), 333);
    }
}

