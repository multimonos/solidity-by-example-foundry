// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";

contract CustomErrors {

    error SpecialError();
    error ErrorWithParams(uint num, bool ok);

    function revertByRequire() public pure {
        require(false, "custom_require_msg");
    }

    function revertByRevert() public pure {
        revert("custom_revert_msg");
    }

    function revertByRevertEmptyMessage() public pure {
        revert();
    }

    function revertByRevertWithError() public pure {
        revert SpecialError();
    }

    function revertByRevertWithErrorAndParams() public pure {
        revert ErrorWithParams(42, false);
    }

    function revertByAssert() public pure {
        assert(true == false);
    }
}


contract TestCustomErrors is Test {
    CustomErrors x;

    function setUp() public {
        x = new  CustomErrors();
    }

    function test_require() public {
        vm.expectRevert();
        x.revertByRequire();
    }

    function test_require_msg() public {
        vm.expectRevert(bytes("custom_require_msg"));
        x.revertByRequire();
    }

    function test_revert() public {
        vm.expectRevert();
        x.revertByRevert();
    }

    function test_revert_msg() public {
        vm.expectRevert(bytes("custom_revert_msg"));
        x.revertByRevert();
    }

    function test_revert_empty_msg() public {
        vm.expectRevert(bytes(""));
        x.revertByRevertEmptyMessage();
    }

    function test_revert_with_custom_error() public {
        vm.expectRevert(CustomErrors.SpecialError.selector);
        x.revertByRevertWithError();
    }

    function test_revert_with_custom_error_params() public {

        console.logBytes(
            abi.encodeWithSelector(CustomErrors.ErrorWithParams.selector, 42, false)
        );

        vm.expectRevert(
            abi.encodeWithSelector(CustomErrors.ErrorWithParams.selector, 42, false)
        );

        x.revertByRevertWithErrorAndParams();
    }

    function test_assert() public {
        vm.expectRevert();
        x.revertByAssert();
    }
}

