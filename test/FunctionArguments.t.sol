// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";

contract FunctionArguments {

    function mutateMemoryString(string memory name) public pure returns (string memory) {
        name = "cat";
        return name;
    }

    function mutateCalldataStringFailsToCompile(string calldata name) public pure returns (string memory) {
//        name = "cat"; // will not compile
        return name;
    }
}

contract FunctionArgumentsTest is Test {

    function test_memory_string_is_mutable() public {
        FunctionArguments fa = new FunctionArguments();
        string memory rs = fa.mutateMemoryString("craig");
        assertEq(rs, "cat");
    }

}
