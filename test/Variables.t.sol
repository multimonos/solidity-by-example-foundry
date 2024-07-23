// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";

contract VariablesTest is Test {

    function test_msg_global() public payable {
        assertNotEq(msg.sender, address(0));
        assertNotEq(keccak256(msg.data), keccak256(""));
    }

    function test_msg_value_not_exists_iff_payable() public {
        // this will throw error
        // assertTrue(msg.value == 0 ether);
    }

    function test_msg_value_exists_if_payable() public payable {
        assertTrue(msg.value == 0 ether);
    }

    function test_tx_global() public view {
        assertTrue(tx.gasprice >= 0);
        assertNotEq(tx.origin, address(0));
    }

    function test_block_global() public view {
        assertTrue(block.basefee >= 0);
//        assertTrue(block.blobbasefee >= 0);
        assertTrue(block.chainid != 0);
        assertTrue(block.timestamp != 0);
//        assertTrue(block.blocknumber != 0);

    }
}
