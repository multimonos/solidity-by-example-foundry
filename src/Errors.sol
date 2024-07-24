// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Errors {

    error SpecialError();
    error ErrorWithParams(uint num, bool ok);

    function revertByRequire() public pure {
        require(false, "custom_require_msg");
    }

    function revertByRevert() public pure {
        revert("custom_revert_msg");
    }

    function revertByRevertEmptyMessage() public pure {
        revert();
    }

    function revertByRevertWithError() public pure {
        revert SpecialError();
    }

    function revertByRevertWithErrorAndParams() public pure {
        revert ErrorWithParams(42, false);
    }

    function revertByAssert() public pure {
        assert(true == false);
    }
}