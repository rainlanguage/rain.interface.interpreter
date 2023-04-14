// SPDX-License-Identifier: CAL
pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import "../src/LibContext.sol";
import "./LibContextSlow.sol";

import "forge-std/console.sol";

contract LibContextHashTest is Test {
    function testFuzzHash0() public pure {
        SignedContextV1[] memory signedContexts_ = new SignedContextV1[](3);
        signedContexts_[0] = SignedContextV1(address(0), new uint256[](5), new bytes(65));
        signedContexts_[1] = SignedContextV1(address(0), new uint256[](5), new bytes(65));
        signedContexts_[2] = SignedContextV1(address(0), new uint256[](5), new bytes(65));

        LibContext.hash(signedContexts_);
    }

    function testHash(uint256 foo_) public pure {
        assembly ("memory-safe") {
            mstore(0x00, foo_)
            pop(keccak256(0x00, 0x20))
        }
    }

    function testHashGas0() public pure {
        assembly ("memory-safe") {
            mstore(0, 0)
            pop(keccak256(0, 0x20))
        }
    }

    function testSignedContextHashReferenceImplementation(SignedContextV1 memory signedContext_) public {
        assertEq(LibContext.hash(signedContext_), LibContextSlow.hashSlow(signedContext_));
    }

    function testSignedContextArrayHashReferenceImplementation0() public {
        SignedContextV1[] memory signedContexts_ = new SignedContextV1[](1);
        signedContexts_[0] = SignedContextV1(address(0), new uint256[](0), "");
        assertEq(LibContext.hash(signedContexts_), LibContextSlow.hashSlow(signedContexts_));
    }

    function testSignedContextHashGas0() public pure {
        SignedContextV1 memory context_ = SignedContextV1(address(0), new uint256[](5), new bytes(65));
        LibContext.hash(context_);
        // 1199 gas
        // bytes memory bytes_ = abi.encode(context_);
        // keccak256(bytes_);
    }

    function testSignedContextHashEncodeGas0() public pure {
        SignedContextV1 memory context_ = SignedContextV1(address(0), new uint256[](5), new bytes(65));
        // 1199 gas
        bytes memory bytes_ = abi.encode(context_);
        keccak256(bytes_);
    }

    /// This is very slow ~10-15s due to the fuzzer taking a long time to produce
    /// the input data for some reason.
    function testSignedContextArrayHashReferenceImplementation(SignedContextV1[] memory signedContexts_) public {
        assertEq(LibContext.hash(signedContexts_), LibContextSlow.hashSlow(signedContexts_));
    }
}
