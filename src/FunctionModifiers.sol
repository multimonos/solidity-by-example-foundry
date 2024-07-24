// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract FunctionModifiers {

    // err
    error NotOwner();
    error InvalidAddress(address);

    // state
    address public owner;
    address public friend;

    // modifier
    modifier onlyOwner() {
        if (owner != msg.sender) revert NotOwner();
        _;
    }

    modifier validAddress(address _address) {
        if (_address == address(0)) revert InvalidAddress(_address);
        _;
    }

    //fns
    constructor() {
        owner = msg.sender;
    }

    function changeOwner(address _newOwner) public onlyOwner {
        owner = _newOwner;
    }

    function friendly(address _address) public validAddress(_address) {
        friend = _address;
    }
}