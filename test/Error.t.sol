// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {Errors} from "../src/Errors.sol";


contract ErrorsTest is Test {

    function test_require() public {
        Errors obj = new Errors();
        vm.expectRevert();
        obj.revertByRequire();
    }

    function test_require_msg() public {
        Errors obj = new Errors();
        vm.expectRevert(bytes("custom_require_msg"));
        obj.revertByRequire();
    }

    function test_revert() public {
        Errors obj = new Errors();
        vm.expectRevert();
        obj.revertByRevert();
    }

    function test_revert_msg() public {
        Errors obj = new Errors();
        vm.expectRevert(bytes("custom_revert_msg"));
        obj.revertByRevert();
    }

    function test_revert_empty_msg() public {
        Errors obj = new Errors();
        vm.expectRevert(bytes(""));
        obj.revertByRevertEmptyMessage();
    }

    function test_revert_with_custom_error() public {
        Errors obj = new Errors();
        vm.expectRevert(Errors.SpecialError.selector);
        obj.revertByRevertWithError();
    }

    function test_revert_with_custom_error_params() public {
        Errors obj = new Errors();

        console.logBytes(
            abi.encodeWithSelector(Errors.ErrorWithParams.selector, 42, false)
        );

        vm.expectRevert(
            abi.encodeWithSelector(Errors.ErrorWithParams.selector, 42, false)
        );

        obj.revertByRevertWithErrorAndParams();
    }

    function test_assert() public {
        Errors obj = new Errors();
        vm.expectRevert();
        obj.revertByAssert();
    }
}

