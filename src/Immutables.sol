// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;


contract Immutables {

    // initialize during construction
    address public immutable MY_ADDRESS;
    uint256 public immutable MY_UINT;
    //int256 public immutable UNSET_UINT; // will throw compile error

    constructor(uint256 _myUint) {
        MY_ADDRESS = msg.sender;
        MY_UINT = _myUint;
    }
}
