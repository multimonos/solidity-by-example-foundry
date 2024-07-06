// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";

contract DataLocations {

    struct MyStruct {
        uint256 foo;
    }

    uint256[] public arr;
    mapping(uint256 => address) map;
    mapping(uint256 => MyStruct) myStructs;

    function f() public {
        // call with state params
        _f(arr, map, myStructs[1]);

        // struct pointer
        MyStruct storage myStructPointer = myStructs[1];

        // create struct
        MyStruct memory myMemStruct = MyStruct(0);
    }

    function _f(
        uint256[] storage _arr,
        mapping(uint256 => address) storage _map,
        MyStruct storage _myStruct
    ) internal {
        // arg refs are all pointers
    }

    function g(uint256[] memory _arr) public returns (uint256[] memory){
        return _arr;
    }

    function h(uint256[] calldata _arr) external {

    }
}



