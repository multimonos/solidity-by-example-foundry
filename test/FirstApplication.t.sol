// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";

contract Counter {

    uint256 public count;

    /// @dev get the current count
    function get() public view returns (uint256) {
        return count;
    }

    /// @dev increment count by 1
    function inc() public {
        count += 1;
    }

    /// @dev decrement count by 1
    function dec() public {
        count -= 1;
    }
}


contract TestCounter is Test {

    function test_initial_counter_is_zero() public {
        Counter counter = new Counter();
        assertEq(counter.count(), 0);
    }

    function test_get_method_same_as_count_getter() public {
        Counter counter = new Counter();
        assertEq(counter.count(), counter.get());
    }

    function test_can_increment() public {
        Counter counter = new Counter();
        assertEq(counter.count(), 0);
        counter.inc();
        assertEq(counter.count(), 1);
    }

    function cannot_decrement_zero() public {
        Counter counter = new Counter();
        assertEq(counter.count(), 0);
        vm.expectRevert();
        counter.dec();
    }

    function can_decrement() public {
        Counter counter = new Counter();
        assertEq(counter.count(), 0);
        counter.inc();
        counter.inc();
        assertEq(counter.count(), 2);
        counter.dec();
        assertEq(counter.count(), 1);
    }
}