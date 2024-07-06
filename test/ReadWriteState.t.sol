// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";

contract SimpleStorage {

    uint256 public num;

    function set(uint256 num_) public {
        num = num_;
    }

    function get() public view returns (uint256){
        return num;
    }

}


contract TestSimpleStorage is Test {

    SimpleStorage x;

    function setUp() public {
        x = new SimpleStorage();
    }

    function test_get() public view {
        // foundry will report less gas
        assertTrue(x.get() == 0);
    }

    function test_set() public {
        x.set(666);
        assertTrue(x.get() == 666);
    }
}

