// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";

contract Primitives {
    // boolean
    bool public bTrue = true;
    bool public bDefault;
    // unsigned int
    uint public uiDefault;
    // signed integer
    int public intDefault;
    // address
    address public addressDefault;
    // constants
    address public constant MY_ADDRESS = 0x777788889999AaAAbBbbCcccddDdeeeEfFFfCcCc;
    uint256 public constant MY_INT = 123;

}

contract TestPrimitives is Test {

    Primitives p;

    function setUp() public {
        p = new Primitives();
    }

    function test_bool_true() public view {
        assert(p.bTrue() == true);
    }

    function test_bool_defaults_false() public view {
        assert(p.bDefault() == false);
    }

    function test_uint_aliasof_uint256() public pure {
        assert(type(uint256).max == type(uint).max);
    }

    function test_uint_default_is_zero() public view {
        assert(p.uiDefault() == type(uint).min);
    }

    function test_int_default_is_zero() public view {
        assert(p.intDefault() == 0);
    }

    function test_address_default_is_zero() public view {
        assert(p.addressDefault() == address(0));
        console.log("address(0): %s", address(0));
    }

    function test_bytes_is_array() public pure {
        string memory sa = "car";
        string memory sb = "seat";

        // string.length does not exist
        // bytes.length exists

        bytes memory a = bytes(sa);
        bytes memory b = bytes(sb);
        bytes memory exp = "carseat";

        assertTrue(a.length == 3);
        assertTrue(b.length == 4);
        assertTrue(exp.length == 7);

        bytes memory nb = new bytes(a.length + b.length);
        assertTrue(nb.length == 7);

        uint j = 0;
        for (uint i = 0; i < a.length; i++) {
            nb[j++] = a[i];
        }
        for (uint i = 0; i < b.length; i++) {
            nb[j++] = b[i];
        }

        assertTrue(nb.length == 7);

        // no native string equality checking
        assertTrue(keccak256(nb) == keccak256(exp));
        assertTrue(keccak256(nb) == keccak256("carseat"));

        string memory sc = string(nb);
        assertTrue(keccak256(bytes(sc)) == keccak256("carseat"));
    }

    function test_constant_access() public view {
        assertTrue(p.MY_INT() == 123);
        assertTrue(p.MY_ADDRESS() == 0x777788889999AaAAbBbbCcccddDdeeeEfFFfCcCc);
    }
}

