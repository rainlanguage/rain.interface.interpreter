// SPDX-License-Identifier: CAL
pragma solidity ^0.8.18;

import "../src/LibEvaluable.sol";

library LibEvaluableSlow {
    function hashEncodeNotPacked(Evaluable memory evaluable_) internal pure returns (bytes32) {
        return keccak256(abi.encode(evaluable_));
    }
}
