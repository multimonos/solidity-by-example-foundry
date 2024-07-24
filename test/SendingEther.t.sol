// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {ReceiveEther, SendEther, FunctionEvents, RevertingReceiver} from "../src/SendingEther.sol";

contract SendingEtherTest is Test, FunctionEvents {

    function test_sender_balance() public {
        SendEther sender = new SendEther();
        assertEq(sender.getBalance(), 0);
    }

    function test_receiver_balance() public {
        ReceiveEther receiver = new ReceiveEther();
        assertEq(receiver.getBalance(), 0);
    }

    function test_send_via_transfer_triggers_receive() public {
        uint amt = 3 ether;

        // setup sender with value a balance
        SendEther sender = new SendEther{value: amt}();
        assertEq(sender.getBalance(), amt);

        // setup receiver
        ReceiveEther receiver = new ReceiveEther();
        assertEq(receiver.getBalance(), 0);

        // trigger receive call
        vm.expectEmit(address(receiver));
        emit ReceiveCalled(amt);
        vm.startPrank(address(sender));
        sender.sendViaTransfer{value: amt}(payable(receiver));
        vm.stopPrank();

        // final state
        assertEq(receiver.getBalance(), amt);
        assertEq(sender.getBalance(), 0);
    }

    function test_send_via_send_triggers_receive() public {
        uint amt = 3 ether;

        // setup sender with value a balance
        SendEther sender = new SendEther{value: amt}();
        assertEq(sender.getBalance(), amt);

        // setup receiver
        ReceiveEther receiver = new ReceiveEther();
        assertEq(receiver.getBalance(), 0);

        // trigger receive call
        vm.expectEmit(address(receiver));
        emit ReceiveCalled(amt);
        vm.startPrank(address(sender));
        sender.sendViaSend{value: amt}(payable(receiver));
        vm.stopPrank();

        // final state
        assertEq(receiver.getBalance(), amt);
        assertEq(sender.getBalance(), 0);
    }

    function test_send_via_call_triggers_receive() public {
        uint amt = 3 ether;

        // setup sender with value a balance
        SendEther sender = new SendEther{value: amt}();
        assertEq(sender.getBalance(), amt);

        // setup receiver
        ReceiveEther receiver = new ReceiveEther();
        assertEq(receiver.getBalance(), 0);

        // trigger receive call
        vm.expectEmit(address(receiver));
        emit ReceiveCalled(amt);
        vm.startPrank(address(sender));
        sender.sendViaCall{value: amt}(payable(receiver), "");
        vm.stopPrank();

        // final state
        assertEq(receiver.getBalance(), amt);
        assertEq(sender.getBalance(), 0);
    }

    function test_send_via_call_triggers_fallback() public {
        uint amt = 3 ether;

        // setup sender with value a balance
        SendEther sender = new SendEther{value: amt}();
        assertEq(sender.getBalance(), amt);

        // setup receiver
        ReceiveEther receiver = new ReceiveEther();
        assertEq(receiver.getBalance(), 0);

        // trigger fallback call
        bytes memory messageData = "0x29a";
        vm.expectEmit(address(receiver));
        emit FallbackCalled(amt, messageData);
        vm.startPrank(address(sender));
        sender.sendViaCall{value: amt}(payable(receiver), messageData);
        vm.stopPrank();

        // final state
        assertEq(receiver.getBalance(), amt);
        assertEq(sender.getBalance(), 0);
    }

    function test_revert_send_via_transfer() public {
        SendEther sender = new SendEther();
        RevertingReceiver receiver = new RevertingReceiver();
        vm.expectRevert();
        sender.sendViaTransfer(payable(receiver));
    }

    function test_revert_send_via_send() public {
        SendEther sender = new SendEther();
        RevertingReceiver receiver = new RevertingReceiver();
        vm.expectRevert();
        sender.sendViaSend(payable(receiver));
    }

    function test_revert_send_via_call_fallback() public {
        SendEther sender = new SendEther();
        RevertingReceiver receiver = new RevertingReceiver();
        vm.expectRevert();
        sender.sendViaCall(payable(receiver), "0x0");
    }

    function test_revert_send_via_call_receive() public {
        SendEther sender = new SendEther();
        RevertingReceiver receiver = new RevertingReceiver();
        vm.expectRevert();
        sender.sendViaCall(payable(receiver), "");
    }
}
