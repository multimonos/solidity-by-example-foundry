// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Functions {
    uint256[] public arr = [uint256(1), 2, 3];

    function returnMany() public pure returns (uint256, bool, uint256){
        return (1, true, 2);
    }

    function returnManyNamed() public pure returns (uint256 x, bool y, uint256 z){
        return (1, true, 2);
    }

    function impliedReturn() public pure returns (uint256 x, bool y, uint256 z) {
        x = 1;
        y = true;
        z = 2;
    }

    function canReturnArray() public view returns (uint256[] memory){
        return arr;
    }

    function consumeArray(uint256[2] memory _arr) public pure returns (uint256[2] memory) {
        for (uint i = 0; i < _arr.length; i++) {
            _arr[i] *= 100;
        }
        return _arr;
    }

    function hasManyInputs(
        uint256 v,
        bool w,
        uint256 x,
        string memory y,
        address z
    ) public pure returns (bool) {
        v += 1;
        x += 2;
        assert(address(3) == z);
        assert(keccak256("foobar") == keccak256(bytes(y)));
        return !w;

    }
}
