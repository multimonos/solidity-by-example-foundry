// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";

contract Immutables {
    address public addressBefore;
    uint256 public intBefore;

    address public immutable MY_ADDRESS;
    uint256 public immutable MY_INT;

    constructor(uint256 myInt_) {
        // save initial
        addressBefore = MY_ADDRESS;
        intBefore = MY_INT;
        // set immutables
        MY_ADDRESS = msg.sender;
        MY_INT = myInt_;
    }
}

contract TestImmutables is Test {

    Immutables x;

    function setUp() public {
        vm.prank(address(3));
        x = new Immutables(666);
    }

    function test_unset_immutable_int_is_zero() public view {
        assertTrue(x.intBefore() == 0);
    }

    function test_immutable_int_value() public view {
        assertTrue(x.MY_INT() == 666);
    }

    function test_unset_address_is_zero() public view {
        assertTrue(x.addressBefore() == address(0));
    }

    function test_immutable_address_is_message_sender() public view {
        assertTrue(x.MY_ADDRESS() == address(3));
    }
}



