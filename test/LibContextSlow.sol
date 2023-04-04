// SPDX-License-Identifier: CAL
pragma solidity ^0.8.18;

import "rain.lib.hash/LibHashNoAlloc.sol";

import "../src/IInterpreterCallerV1.sol";

library LibContextSlow {
    function hashSlow(SignedContext memory signedContext_) internal pure returns (bytes32) {
        bytes32[] memory aWords_ = new bytes32[](1);
        aWords_[0] = bytes32(uint256(uint160(signedContext_.signer)));
        bytes32 a_ = LibHashNoAlloc.hash(aWords_);
        bytes32 b_ = LibHashNoAlloc.hash(signedContext_.context);
        bytes32 c_ = LibHashNoAlloc.hash(a_, b_);
        bytes32 d_ = LibHashNoAlloc.hash(signedContext_.signature);
        bytes32 e_ = LibHashNoAlloc.hash(c_, d_);
        return e_;
    }
}