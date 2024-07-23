// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {PrimitiveDataTypes} from "../src/PrimitiveDataTypes.sol";


contract TestPrimitives is Test {

    PrimitiveDataTypes public obj;

    function setUp() public {
        obj = new PrimitiveDataTypes();
    }

    function test_bool_true() public view {
        assertTrue(obj.boo());
    }

    function test_bool_defaults_false() public view {
        assert(obj.defaultBoo() == false);
    }

    function test_uint_aliasof_uint256() public pure {
        assert(type(uint256).max == type(uint).max);
        assert(type(uint256).min == type(uint).min);
    }

    function test_uint_default_is_zero() public view {
        assert(obj.defaultUint() == type(uint).min);
    }

    function test_int_default_is_zero() public view {
        assert(obj.defaultInt() == 0);
    }

    function test_address_default_is_0x0() public view {
        assert(obj.defaultAddr() == address(0));
    }

    function test_bytes_is_array() public pure {
        // expected
        bytes memory exp = "carseat";

        // create 2 strings
        string memory sa = "car";
        string memory sb = "seat";

        // cast string->bytes is ok
        bytes memory a = bytes(sa);
        bytes memory b = bytes(sb);

        // bytes.length exists
        // string.length does not
        assertTrue(a.length == 3);
        assertTrue(b.length == 4);
        assertTrue(exp.length == 7);

        // allocate memory for new bytes
        bytes memory nb = new bytes(a.length + b.length);
        assertTrue(nb.length == 7);

        // copy all of "a" and all of "b" into nb
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

        // cast bytes->string ok
        string memory sc = string(nb);
        assertTrue(keccak256(bytes(sc)) == keccak256("carseat"));
    }
}