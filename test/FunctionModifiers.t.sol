// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";

contract FunctionModifiers {

    address public owner;
    address public friend;

    error NotOwner();
    error InvalidAddress(address);

    modifier onlyOwner() {
        if (owner != msg.sender) revert NotOwner();
        _;
    }

    modifier validAddress(address _address) {
        if (_address == address(0)) revert InvalidAddress(_address);
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function changeOwner(address _newOwner) public onlyOwner {
        owner = _newOwner;
    }

    function friendly(address _address) public validAddress(_address) {
        friend = _address;
    }
}

contract FunctionModifiersTest is Test {

    FunctionModifiers fm;
    address owner;

    function setUp() public {
        owner = address(3);
        vm.prank(owner);
        fm = new FunctionModifiers();
    }

    function test_only_owner_modifier_pass() public {
        vm.prank(owner);
        fm.changeOwner(address(5));
        assertTrue(fm.owner() == address(5));
    }

    function test_only_owner_modifier_fail() public {
        vm.expectRevert(FunctionModifiers.NotOwner.selector);
        vm.prank(address(4));
        fm.changeOwner(address(4));
    }

    function test_valid_address_modifier_pass() public {
        fm.friendly(address(3));
        assert(fm.friend() == address(3));
    }

    function test_valid_address_modifier_fail() public {
        vm.expectRevert(
            abi.encodeWithSelector(FunctionModifiers.InvalidAddress.selector, address(0))
        );
        fm.friendly(address(0));
    }
}

