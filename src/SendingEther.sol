// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract FunctionEvents {
    event ReceiveCalled(uint256 amount);
    event FallbackCalled(uint256 amount, bytes data);
}

contract RevertingReceiver is FunctionEvents {
    receive() external payable {
        emit ReceiveCalled(msg.value);
        revert("forced");
    }

    fallback() external payable {
        emit FallbackCalled(msg.value, msg.data);
        revert("forced");
    }
}

contract ReceiveEther is FunctionEvents {
    /*
    Which function is called, fallback() or receive()?

           send Ether
               |
         msg.data is empty?
              / \
            yes  no
            /     \
    receive() exists?  fallback()
         /   \
        yes   no
        /      \
    receive()   fallback()
    */

    // Function to receive Ether. msg.data must be empty
    receive() external payable {
        emit ReceiveCalled(msg.value);
    }

    // Fallback function is called when msg.data is not empty
    fallback() external payable {
        emit FallbackCalled(msg.value, msg.data);
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}

contract SendEther {
    constructor() payable {}

    function sendViaTransfer(address payable _to) public payable {
        // This function is no longer recommended for sending Ether.
        _to.transfer(msg.value);
    }

    function sendViaSend(address payable _to) public payable {
        // Send returns a boolean value indicating success or failure.
        // This function is not recommended for sending Ether.
        bool sent = _to.send(msg.value);
        require(sent, "Failed to send Ether");
    }

    function sendViaCall(address payable _to, bytes memory msgData) public payable {
        // Call returns a boolean value indicating success or failure.
        // This is the current recommended method to use.
        (bool sent, bytes memory data) = _to.call{value: msg.value}(msgData);
        require(sent, "Failed to send Ether");
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}