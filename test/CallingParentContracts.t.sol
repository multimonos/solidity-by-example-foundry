// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {LogEvents, A, B, C, D} from "../src/CallingParentContracts.sol";

contract CallingParentContractsTest is Test, LogEvents {

    A public a;
    B public b;
    C public c;
    D public d;

    function setUp() external {
        a = new A();
        b = new B();
        c = new C();
        d = new D();
    }

    function test_a_foo() public {
        vm.expectEmit(address(a));
        emit LogA_Foo();
        a.foo();
    }

    function test_a_bar() public {
        vm.expectEmit(address(a));
        emit LogA_Bar();
        a.bar();
    }

    function test_b_foo_calls_a() public {
        vm.expectEmit(address(b));
        emit LogB_Foo();
        vm.expectEmit(address(b));
        emit LogA_Foo();
        b.foo();
    }

    function test_b_bar_calls_a() public {
        vm.expectEmit(address(b));
        emit LogB_Bar();
        vm.expectEmit(address(b));
        emit LogA_Bar();
        b.bar();
    }

    function test_c_foo_calls_a() public {
        vm.expectEmit(address(c));
        emit LogC_Foo();
        vm.expectEmit(address(c));
        emit LogA_Foo();
        c.foo();
    }

    function test_c_bar_calls_a() public {
        vm.expectEmit(address(c));
        emit LogC_Bar();
        vm.expectEmit(address(c));
        emit LogA_Bar();
        c.bar();
    }

    function test_Dfoo_only_calls_Cfoo_then_Afoo() public {
        // ... and this is why i don't love indheritance...
        vm.expectEmit(address(d));
        emit LogC_Foo();
        vm.expectEmit(address(d));
        emit LogA_Foo();
        d.foo();
    }

    function test_Dbar_calls_Cbar_then_Bbar_then_Abar() public {
        // ... and this is why i don't love indheritance...
        vm.expectEmit(address(d));
        emit LogC_Bar();
        vm.expectEmit(address(d));
        emit LogB_Bar();
        vm.expectEmit(address(d));
        emit LogA_Bar();
        d.bar();
    }
}
