// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";

import {Base, Child, VisibilityEvents} from "../src/Visibility.sol";

contract VisibilityTest is Test, VisibilityEvents {

    Base public base;
    Child public child;

    function setUp() external {
        base = new Base();
        child = new Child();
    }

    function test_external_fn() public {
        vm.expectEmit(address(base));
        emit ExternalFunctionCalled();
        base.externalFunc();
    }

    function test_public_fn() public {
        vm.expectEmit(address(base));
        emit PublicFunctionCalled();
        base.publicFunc();
    }

    function test_internal_fn() public {
        vm.expectEmit(address(base));
        emit PublicFunctionCalled();
        vm.expectEmit(address(base));
        emit InternalFunctionCalled();
        base.testInternalFunc();
    }

    function test_private_fn() public {
        vm.expectEmit(address(base));
        emit PublicFunctionCalled();
        vm.expectEmit(address(base));
        emit PrivateFunctionCalled();
        base.testPrivateFunc();
    }


    function test_child_can_call_parents_internal_fns() public {
        vm.expectEmit(address(child));
        emit PublicFunctionCalled();
        vm.expectEmit(address(child));
        emit InternalFunctionCalled();
        child.testInternalFunc();
    }
}