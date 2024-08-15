// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Arrays {
    // storage array can declare + assign values
    uint[] public nums = [1, 2, 3];
    address[] public users;

    function addUsers(address[] memory list) public {
        for (uint i = 0; i < list.length; i++) {
            users.push(list[i]);
        }
    }

    function getUserCount() public view returns (uint){
        return users.length;
    }

    function getUsers() public view returns (address[] memory){
        return users;
    }
}
