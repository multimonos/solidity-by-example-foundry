// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract VisibilityEvents {
    event PublicFunctionCalled();
    event InternalFunctionCalled();
    event PrivateFunctionCalled();
    event ExternalFunctionCalled();

}

contract Base is VisibilityEvents {
    // Private function can only be called
    // - inside this contract
    // Contracts that inherit this contract cannot call this function.
    function privateFunc() private returns (string memory) {
        emit PrivateFunctionCalled();
        return "private function called";
    }

    function testPrivateFunc() public returns (string memory) {
        emit PublicFunctionCalled();
        return privateFunc();
    }

    // Internal function can be called
    // - inside this contract
    // - inside contracts that inherit this contract
    function internalFunc() internal returns (string memory) {
        emit InternalFunctionCalled();
        return "internal function called";
    }

    function testInternalFunc() public virtual returns (string memory) {
        emit PublicFunctionCalled();
        return internalFunc();
    }

    // Public functions can be called
    // - inside this contract
    // - inside contracts that inherit this contract
    // - by other contracts and accounts
    function publicFunc() public returns (string memory) {
        emit PublicFunctionCalled();
        return "public function called";
    }

    // External functions can only be called
    // - by other contracts and accounts
    function externalFunc() external returns (string memory) {
        emit ExternalFunctionCalled();
        return "external function called";
    }

    // This function will not compile since we're trying to call
    // an external function here.
    // function testExternalFunc() public pure returns (string memory) {
    //     return externalFunc();
    // }

    // State variables
    string private privateVar = "my private variable";
    string internal internalVar = "my internal variable";
    string public publicVar = "my public variable";
    // State variables cannot be external so this code won't compile.
    // string external externalVar = "my external variable";
}

contract Child is Base {
    // Inherited contracts do not have access to private functions
    // and state variables.
    // function testPrivateFunc() public pure returns (string memory) {
    //     return privateFunc();
    // }

    // Internal function can be called inside child contracts.
    function testInternalFunc() public override returns (string memory) {
        emit PublicFunctionCalled();
        return internalFunc();
    }
}