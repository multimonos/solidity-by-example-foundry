// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {HelloWorld} from "../src/HelloWorld.sol";


contract HelloWorldTest is Test {

    HelloWorld public obj;

    function setUp() external {
        obj = new HelloWorld();
    }

    function test_greeting() public view {
        assertEq(obj.greet(), "Hello World!");
    }

    function test_public_method_has_magic_getter() public view {
        assertNotEq(obj.greet(), "");
    }
}
