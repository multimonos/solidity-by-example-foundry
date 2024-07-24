// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract LogEvents {
    event LogA_Foo();
    event LogA_Bar();
    event LogB_Foo();
    event LogB_Bar();
    event LogC_Foo();
    event LogC_Bar();
}

contract A is LogEvents {

    function foo() public virtual {
        emit LogA_Foo();
    }

    function bar() public virtual {
        emit LogA_Bar();
    }
}

contract B is A {

    function foo() public virtual override {
        emit LogB_Foo();
        A.foo();
    }

    function bar() public virtual override {
        emit LogB_Bar();
        super.bar();
    }
}

contract C is A {
    function foo() public virtual override {
        emit LogC_Foo();
        A.foo();
    }

    function bar() public virtual override {
        emit LogC_Bar();
        super.bar();
    }
}

contract D is B, C {
    // Try:
    // - Call D.foo and check the transaction logs.
    //   Although D inherits A, B and C, it only called C and then A.
    // - Call D.bar and check the transaction logs
    //   D called C, then B, and finally A.
    //   Although super was called twice (by B and C) it only called A once.

    function foo() public override(B, C) {
        super.foo();
    }

    function bar() public override(B, C) {
        super.bar();
    }
}
