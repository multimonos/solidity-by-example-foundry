// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {CustomEvents, EventEmitter} from "../src/EventEmiiter.sol";


contract EventsTest is Test, CustomEvents {

    EventEmitter public radio;

    function setUp() public {
        radio = new EventEmitter();
    }

    function test_simple_event() public {
        vm.expectEmit();
        emit SimpleEvent();
        radio.emitSimpleEvent();
    }

    function test_event_with_data() public {
        bool isTrue = true;
        uint8 count = 25;
        vm.expectEmit();
        emit EventWithData(isTrue, count);
        radio.emitEventWithData(isTrue, count);
    }

    function test_indexed_topic_event() public {
        address to = address(6);
        bool value = true;

        vm.expectEmit();

        emit IndexedTopicEvent(msg.sender, to, value);
        radio.emitIndexedTopicEvent(msg.sender, to, value);
    }

    function test_indexed_topic_event_explicitly() public {
        address to = address(6);
        bool value = true;

        // verbose expectEmit() example as it's a little silly.
        bool matchTopic1 = true;
        bool matchTopic2 = false; // not in use
        bool matchTopic3 = false; // not in use
        bool eventDataShouldMatch = true;
        address whichContractEmittedTheEvent = address(radio);
        vm.expectEmit(
            matchTopic1,
            matchTopic2,
            matchTopic3,
            eventDataShouldMatch,
            whichContractEmittedTheEvent
        );

        emit IndexedTopicEvent(msg.sender, to, value);

        radio.emitIndexedTopicEvent(msg.sender, to, value);
    }

    function test_indexed_topic_event_explicitly_data_irrelevant() public {

        // verbose expectEmit() example as this cheatcode is a bit confusing.

        // all the cheatcode params
        bool matchTopic1 = false;
        bool matchTopic2 = false; // not in use
        bool matchTopic3 = false; // not in use
        bool eventDataShouldMatch = false; // change to "true" and this test will fail
        address whoWillEmitTheEvent = address(radio);
        vm.expectEmit(
            matchTopic1,
            matchTopic2,
            matchTopic3,
            eventDataShouldMatch,
            whoWillEmitTheEvent
        );

        // create an event that does not match
        emit IndexedTopicEvent(
            makeAddr("unknown_address"), // should be msg.sender
            makeAddr("unknown_receipient"), // should be "to" ( see below )
            false // should be "true"
        );

        // emit event that does not match
        address to = address(6);
        radio.emitIndexedTopicEvent(
            msg.sender,
            to,
            true
        );
    }
}

