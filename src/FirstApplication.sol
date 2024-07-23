// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract FirstApplication {

    // state
    uint256 public count;

    function get() public view returns (uint256) {
        return count;
    }

    function inc() public {
        count += 1;
    }

    function dec() public {
        count -= 1;
    }
}
