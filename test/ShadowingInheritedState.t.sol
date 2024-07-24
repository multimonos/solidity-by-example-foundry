// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {A, B} from "../src/ShadowingInheritedState.sol";

contract ShadowingInheritedStateTest is Test {

    function test_parent_name() public {
        A a = new A();
        assertEq(a.getName(), "AAA");
    }

    function test_parent_name2() public {
        A a = new A();
        assertEq(a.name(), "AAA");
    }

    function test_descendant_name() public {
        B b = new B();
        assertEq(b.getName(), "BBB");
    }

    function test_descendant_name2() public {
        B b = new B();
        assertEq(b.name(), "BBB");
    }
}
