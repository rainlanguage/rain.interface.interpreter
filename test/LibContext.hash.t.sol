// SPDX-License-Identifier: CAL
pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import "../src/LibContext.sol";
import "./LibContextSlow.sol";

import "forge-std/console.sol";

contract LibContextHashTest is Test {
    function testFuzzHash0() public {
        SignedContext[] memory signedContexts_ = new SignedContext[](3);
        signedContexts_[0] = SignedContext(address(0), new uint256[](5), new bytes(65));
        signedContexts_[1] = SignedContext(address(0), new uint256[](5), new bytes(65));
        signedContexts_[2] = SignedContext(address(0), new uint256[](5), new bytes(65));

        LibContext.hash(signedContexts_);
    }

    function testHash(uint256 foo_) public {
        assembly ("memory-safe") {
            mstore(0x00, foo_)
            pop(keccak256(0x00, 0x20))
        }
    }

    function testHashGas0() public {
        assembly ("memory-safe") {
            mstore(0, 0)
            pop(keccak256(0, 0x20))
        }
    }

    function testSignedContextHashReferenceImplementation(SignedContext memory signedContext_) public {
        assertEq(LibContext.hash(signedContext_), LibContextSlow.hashSlow(signedContext_));
    }

    function testSignedContextArrayHashReferenceImplementation(SignedContext[] memory signedContexts_) public {
        assertEq(LibContext.hash(signedContexts_), LibContextSlow.hashSlow(signedContexts_));
    }

    function testSignedContextHashGas0() public {
        SignedContext memory context_ = SignedContext(address(0), new uint256[](5), new bytes(65));
        LibContext.hash(context_);
        // 1199 gas
        // bytes memory bytes_ = abi.encode(context_);
        // keccak256(bytes_);
    }

    function testSignedContextHashEncodeGas0() public {
        SignedContext memory context_ = SignedContext(address(0), new uint256[](5), new bytes(65));
        // 1199 gas
        bytes memory bytes_ = abi.encode(context_);
        keccak256(bytes_);
    }
}
