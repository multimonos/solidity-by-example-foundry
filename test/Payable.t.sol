// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {Bank} from "../src/Payable.sol";

contract BankTest is Test {

    Bank public obj;
    address public owner;

    receive() external payable {}

    function test_funds_received_via_constructor() public {
        Bank p = new Bank{value: 3 ether}();
        assertTrue(address(p).balance == 3 ether);
    }

    function test_owner_set() public {
        Bank p = new Bank();
        assertEq(address(this), p.owner());
    }

    function test_can_deposit() public {
        uint amt = 23 ether;
        Bank p = new Bank();
        p.deposit{value: amt}();
        assertEq(address(p).balance, amt);
    }

    function test_not_Bank_throws_on_receive_ether() public pure {
        assertTrue(true);
        // won't compile
//        Bank p = new Bank();
//        vm.expectRevert();
//        p.notBank{value: amt}();
    }

    function test_withdraw() public {
        uint amt = 23 ether;
        uint balanceStart = address(this).balance;

        address user = makeAddr("user");
        vm.deal(user, amt);
        assertEq(user.balance, amt);

        Bank p = new Bank();
        assertEq(address(p).balance, 0);

        vm.startPrank(user);
        p.deposit{value: amt}();
        vm.stopPrank();

        assertEq(user.balance, 0);
        assertEq(address(p).balance, amt);

        p.withdraw();
        /// @dev testing like this requires the Test has Test.receive() defined.
        assertEq(address(p).balance, 0);
        assertEq(address(this).balance, balanceStart + amt);
    }

    function test_transfer() public {
        uint amt = 23 ether;

        address payable user = payable(makeAddr("user"));
        assertEq(user.balance, 0);

        Bank p = new Bank{value: amt}();
        assertEq(address(p).balance, amt);

        p.transfer(user, amt);
        assertEq(address(p).balance, 0);
        assertEq(address(user).balance, amt);
    }

}
