// SPDX-License-Identifier: CAL
pragma solidity ^0.8.18;

import "../src/LibEvaluable.sol";

library LibEvaluableSlow {
    function hashSlow(Evaluable memory evaluable_) internal pure returns (bytes32) {
        return keccak256(
            abi.encodePacked(
                uint256(uint160(address(evaluable_.interpreter))),
                uint256(uint160(address(evaluable_.store))),
                uint256(uint160(evaluable_.expression))
            )
        );
    }
}
