// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {FunctionModifiers} from "../src/FunctionModifiers.sol";

contract FunctionModifiersTest is Test {

    FunctionModifiers public fm;
    address public owner = makeAddr("owner");
    address public notOwner = makeAddr("not_owner");
    address public friend = address(3);
    address public enemy = address(0);

    function setUp() public {
        vm.prank(owner);
        fm = new FunctionModifiers();
    }

    function test_only_owner_can_change_owner() public {
        vm.prank(owner);
        fm.changeOwner(notOwner);
        assertTrue(fm.owner() == notOwner);
    }

    function test_revert_if_other_changes_owner() public {
        vm.expectRevert(FunctionModifiers.NotOwner.selector);
        vm.prank(notOwner);
        fm.changeOwner(notOwner);
    }

    function test_friendly_if_not_zero_address() public {
        fm.friendly(friend);
        assert(fm.friend() == friend);
    }

    function test_zero_address_is_not_friendly() public {
        vm.expectRevert(
            abi.encodeWithSelector(FunctionModifiers.InvalidAddress.selector, enemy)
        );
        fm.friendly(enemy);
    }
}

