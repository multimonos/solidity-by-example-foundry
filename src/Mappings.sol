// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract BasicMapping {

    mapping(address => uint256) public myMap;

    function get(address addr) public view returns (uint256) {
        // access not available for myMap('address')
        return myMap[addr];
    }

    function set(address addr, uint256 i) public {
        myMap[addr] = i;
    }

    function remove(address addr) public {
        delete myMap[addr];
    }
}

contract NestedMapping {
    // Nested mapping (mapping from address to another mapping)
    mapping(address => mapping(uint256 => bool)) public nested;

    function get(address addr1, uint256 i) public view returns (bool) {
        // You can get values from a nested mapping
        // even when it is not initialized
        return nested[addr1][i];
    }

    function set(address addr1, uint256 i, bool boo) public {
        nested[addr1][i] = boo;
    }

    function remove(address addr1, uint256 i) public {
        delete nested[addr1][i];
    }
}