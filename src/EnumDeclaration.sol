// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

enum Status {
    Pending,
    Shipped,
    Accepted,
    Rejected,
    Canceled
}

contract Order {
    Status public status;
}