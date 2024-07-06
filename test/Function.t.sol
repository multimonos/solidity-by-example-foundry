// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";

contract Functions {
    function returnMany() public pure returns (uint256, bool, uint256){
        return (1, true, 2);
    }

    function returnManyNamed() public pure returns (uint256 x, bool y, uint256 z){
        return (1, true, 2);
    }

    function impliedReturn() public pure returns (uint256 x, bool y, uint256 z) {
        x = 1;
        y = true;
        z = 2;
    }

    uint256[] public arr = [uint256(1), 2, 3];

    function canReturnArray() public view returns (uint256[] memory){
        return arr;
    }

    function consumeArray(uint256[2] memory _arr) public pure returns (uint256[2] memory) {
        for (uint i = 0; i < _arr.length; i++) {
            _arr[i] *= 100;
        }
        return _arr;
    }

    function hasManyInputs(
        uint256 v,
        bool w,
        uint256 x,
        string memory y,
        address z
    ) public pure returns (bool) {
        v += 1;
        x += 2;
        assert(address(3) == z);
        assert(keccak256("foobar") == keccak256(bytes(y)));
        return !w;

    }
}

contract TestFunctions is Test {

    Functions f;

    function setUp() public {
        f = new Functions();
    }

    function test_can_return_many() public view {
        (uint256 x, bool y, uint256 z) = f.returnMany();
        assertTrue(x == 1);
        assertTrue(y == true);
        assertTrue(z == 2);
    }

    function test_can_return_many_named() public view {
        (uint256 x, bool y, uint256 z) = f.returnManyNamed();
        // return names are irrelevant, documentation only
        assertTrue(x == 1);
        assertTrue(y == true);
        assertTrue(z == 2);
    }

    function test_named_return_values_do_not_require_return_keyword() public view {
        (uint256 x, bool y, uint256 z) = f.impliedReturn();
        assertTrue(x == 1);
        assertTrue(y == true);
        assertTrue(z == 2);
    }

    function test_return_array() public view {
        uint256[] memory a = f.canReturnArray();
        assertTrue(a.length == 3);
    }

    function test_consume_array() public view {
        uint256[2] memory a = [uint256(11), 22];
        uint256[2] memory b = f.consumeArray(a);

        assertTrue(a[0] == 11);
        assertTrue(a[1] == 22);
        assertTrue(b[0] == 1100);
        assertTrue(b[1] == 2200);
    }

    function test_call_named() public view {
        bool w = false;
        bool rs = f.hasManyInputs({
            v: 12,
            w: w,
            x: 4565,
            z: address(3),
            y: "foobar"
        });
        assertTrue(rs);
    }
}

