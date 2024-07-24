// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";


contract Ace {
    function foo() public pure virtual returns (string memory){
        return "base";
    }
}

contract B is Ace {
    function foo() public pure virtual override returns (string memory){
        return "B";
    }
}

contract C is Ace {
    function foo() public pure virtual override returns (string memory){
        return "C";
    }
}

contract D is B, C {
    function foo() public pure virtual override(B, C) returns (string memory) {
        return super.foo();
    }
}

contract E is C, B {
    function foo() public pure virtual override(B, C) returns (string memory){
        return super.foo();
    }
}

contract InheritanceTest is Test {

    function test_ace_is_base() public {
        Ace a = new Ace();
        assertEq(a.foo(), "base");
    }

    function test_b() public {
        B b = new B();
        assertEq(b.foo(), "B");
    }

    function test_c() public {
        C c = new C();
        assertEq(c.foo(), "C");
    }

    function test_order_matters() public {
        D d = new D();
        E e = new E();

        assertEq(d.foo(), "C");
        assertEq(e.foo(), "B");
    }
}

