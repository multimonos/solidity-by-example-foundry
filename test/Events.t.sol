// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";


contract Events {

    event SaveMe();
    event StopChildrenLook(bool nowish, uint8 numberPeople);

    function help() external {
        emit SaveMe();
    }

    function somethingHappeningHere() external {
        emit StopChildrenLook(true, 5);
    }
}

contract TestEvents is Test {

    Events radio;

    function setUp() public {
        radio = new Events();
    }

    function test_save_me() public {
        vm.expectEmit();
        emit Events.SaveMe();
        radio.help();
    }

    function test_stop_children_look() public {
        vm.expectEmit();
        emit Events.StopChildrenLook(true,5);
        radio.somethingHappeningHere();
    }

    // @todo More refined events testing examples.
}

