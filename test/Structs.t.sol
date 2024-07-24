// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {Todo, Todos} from "../src/Structs.sol";

contract StructsTest is Test {

    function test_init_as_function() public pure {
        Todo memory x = Todo("foobar", false);
        assertTrue(keccak256(bytes(x.text)) == keccak256("foobar"));
        assertEq(x.text, "foobar"); // easier to read
        assertFalse(x.completed);
    }

    function test_init_as_dict() public pure {
        Todo memory x = Todo({
            text: "foobar",
            completed: false
        });
        assertEq(x.text, "foobar");
        assertFalse(x.completed);
    }

    function test_declare_then_init() public pure {
        Todo memory x;
        assertEq(x.text, "");
        assertFalse(x.completed);
        x.text = "foobar";
        x.completed = true;
        assertEq(x.text, "foobar");
        assertTrue(x.completed);
    }

    function test_create() public {
        Todos list = new Todos();
        list.create("foobar");
        // if using magic getter, must destructure
        (string memory text, bool isComplete) = list.todos(0);
        assertEq(text, "foobar");
        assertFalse(isComplete);
    }

    function test_get() public {
        Todos list = new Todos();
        list.create("foobar");
        (string memory text, bool isComplete) = list.get(0);
        assertEq(text, "foobar");
        assertFalse(isComplete);
    }

    function test_get_todo() public {
        Todos list = new Todos();
        list.create("foobar");
        // custom getter allows return Todo
        Todo memory x = list.getTodo(0);
        assertEq(x.text, "foobar");
        assertFalse(x.completed);
    }

    function test_update_text() public {
        Todos list = new Todos();
        list.create("foobar");
        assertEq(list.getTodo(0).text, "foobar");
        list.updateText(0, "baz");
        assertEq(list.getTodo(0).text, "baz");
    }

    function test_toggle_completed() public {
        Todos list = new Todos();
        list.create("foobar");
        assertFalse(list.getTodo(0).completed);
        list.toggleCompleted(0);
        assertTrue(list.getTodo(0).completed);
    }
}
