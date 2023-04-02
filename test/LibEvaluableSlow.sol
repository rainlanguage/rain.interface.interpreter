// SPDX-License-Identifier: CAL
pragma solidity ^0.8.18;

import "../src/LibEvaluable.sol";

library LibEvaluableSlow {
    function hashEncodeNotPacked(Evaluable memory evaluable_) internal pure returns (bytes32) {
        return keccak256(abi.encode(evaluable_));
    }

    function hashEncodePacked(Evaluable memory evaluable_) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked(evaluable_.interpreter, evaluable_.store, evaluable_.expression));
    }
}
