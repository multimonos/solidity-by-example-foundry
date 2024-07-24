// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

// this pattern makes for easier testing
contract CustomEvents {
    event SimpleEvent();
    event EventWithData(bool isCrowded, uint8 numberPeople);
    event IndexedTopicEvent(address indexed from, address to, bool isFriendly);
}

contract EventEmitter is CustomEvents {

    function emitSimpleEvent() external {
        emit SimpleEvent();
    }

    function emitEventWithData(bool isCrowded, uint8 numberPeople) external {
        emit EventWithData(isCrowded, numberPeople);
    }

    function emitIndexedTopicEvent(address from, address to, bool isFriendly) external {
        emit IndexedTopicEvent(from, to, isFriendly);
    }
}
