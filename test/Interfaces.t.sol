// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {Counter, ICounter, MyContract} from "../src/Interfaces.sol";

contract InterfacesTest is Test {

    function test_increment_by_proxy() public {
        Counter counter = new Counter();
        MyContract proxy = new MyContract();
        assertEq(counter.count(), 0);
        proxy.incrementCounter(address(counter));
        assertEq(counter.count(), 1);
    }

    function test_get_count_by_proxy() public {
        Counter counter = new Counter();
        MyContract proxy = new MyContract();
        uint count = proxy.getCount(address(counter));
        assertEq(count, 0);
        proxy.incrementCounter(address(counter));
        assertEq(counter.count(), 1);
        assertEq(proxy.getCount(address(counter)), 1);
    }
}
