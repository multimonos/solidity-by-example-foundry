// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract SimpleStorage {

    uint256 public num;
    uint256 private _foobar = 23;

    function set(uint256 num_) public {
        num = num_; // prevent mangling re solidity styleguide
    }

    function get() public view returns (uint256){
        return num;
    }
}