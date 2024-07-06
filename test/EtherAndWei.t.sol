// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";


contract TestEtherAndWei is Test {
    function test_one_wei_is_1() public pure {
        assertTrue(1 wei == 1);
    }

    function test_one_gwei() public pure {
        assertTrue(1e9 == 1 gwei);
    }

    function test_one_ether() public pure {
        assertTrue(1e18 == 1 ether);
    }
}

