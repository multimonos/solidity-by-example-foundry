// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";


contract A {

}

contract B {
    string public name;

    constructor(string memory name_) {
        name = name_;
    }
}

contract C is A, B("blammo") {

}

contract D is A, B {
    constructor(string memory name_) B(name_){

    }
}

contract ContstructorsTest is Test {

    function test_constructor_is_optional() public {
        A a = new A();
        assertTrue(address(0) != address(a));
    }

    function test_constructor_with_single_argument() public {
        B b = new B("foobar");
        assertTrue(keccak256(bytes(b.name())) == keccak256("foobar"));
    }

    function test_init_inherited_params_statically() public {
        C c = new C();
        assertTrue(keccak256(bytes(c.name())) == keccak256("blammo"));
    }

    function test_init_inherited_params_dynamically() public {
        D d = new D("baz");
        assertTrue(keccak256(bytes(d.name())) == keccak256("baz"));
    }
}