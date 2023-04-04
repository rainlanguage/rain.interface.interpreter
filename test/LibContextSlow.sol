// SPDX-License-Identifier: CAL
pragma solidity ^0.8.18;

import "rain.lib.hash/LibHashNoAlloc.sol";
import "rain.lib.typecast/LibCast.sol";
import "sol.lib.memory/LibUint256Array.sol";

import "../src/IInterpreterCallerV1.sol";

library LibContextSlow {
    using LibUint256Array for uint256;
    using LibCast for uint256[];
    function hashSlow(SignedContext memory signedContext_) internal pure returns (bytes32) {
        bytes32 a_ = LibHashNoAlloc.hashWords(uint256(uint160(signedContext_.signer)).arrayFrom().asBytes32());
        bytes32 b_ = LibHashNoAlloc.hashWords(signedContext_.context.asBytes32());
        bytes32 c_ = LibHashNoAlloc.combineHashes(a_, b_);
        bytes32 d_ = LibHashNoAlloc.hashBytes(signedContext_.signature);
        bytes32 e_ = LibHashNoAlloc.combineHashes(c_, d_);
        return e_;
    }
}