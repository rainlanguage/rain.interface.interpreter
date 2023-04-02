// SPDX-License-Identifier: CAL
pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import "../src/LibContext.sol";

import "forge-std/console.sol";

contract LibContextTest is Test {
    function testBase() public {
        uint256[] memory baseContext_ = LibContext.base();

        assertEq(baseContext_.length, 2);
        assertEq(baseContext_[0], uint256(uint160(msg.sender)));
        assertEq(baseContext_[1], uint256(uint160(address(this))));
        assertTrue(msg.sender != address(this));
    }

    function testFuzzHash1() public {
        SignedContext[] memory signedContexts_ = new SignedContext[](3);
        signedContexts_[0] = SignedContext(address(0), new bytes(65), new uint256[](5));
        signedContexts_[1] = SignedContext(address(0), new bytes(65), new uint256[](5));
        signedContexts_[2] = SignedContext(address(0), new bytes(65), new uint256[](5));

        LibContext.hash1(signedContexts_);
    }

    function testFuzzHash0() public {
        SignedContext[] memory signedContexts_ = new SignedContext[](3);
        signedContexts_[0] = SignedContext(address(0), new bytes(65), new uint256[](5));
        signedContexts_[1] = SignedContext(address(0), new bytes(65), new uint256[](5));
        signedContexts_[2] = SignedContext(address(0), new bytes(65), new uint256[](5));

        LibContext.hash0(signedContexts_);
    }

    // function testFuzzHash1(SignedContext[] memory signedContexts_) public {
    //     LibContext.hash1(signedContexts_);
    // }

    // function testFuzzHash0(SignedContext[] memory signedContexts_) public {
    //     LibContext.hash0(signedContexts_);
    // }

    // function testHash0() public {
    //     // @todo test this better.
    //     assertEq(
    //         bytes32(0x569e75fc77c1a856f6daaf9e69d8a9566ca34aa47f9133711ce065a571af0cfd),
    //         LibContext.hash(new SignedContext[](0))
    //     );
    // }

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

    function testSignedContextHashGas0() public {
        SignedContext memory context_ = SignedContext(address(0), new bytes(65), new uint256[](5));
        LibContext.hash(context_);
        // 1199 gas
        // bytes memory bytes_ = abi.encode(context_);
        // keccak256(bytes_);
    }

    function testSignedContextHashEncodeGas0() public {
        SignedContext memory context_ = SignedContext(address(0), new bytes(65), new uint256[](5));
        // 1199 gas
        bytes memory bytes_ = abi.encode(context_);
        keccak256(bytes_);
    }

    function testBuild0() public {
        // @todo test this better.
        uint256[][] memory expected_ = new uint256[][](2);
        expected_[0] = LibContext.base();
        expected_[1] = new uint256[](0);
        uint256[][] memory built_ = LibContext.build(new uint256[][](0), new uint256[](0), new SignedContext[](0));
        assertEq(expected_.length, built_.length);

        for (uint256 i_ = 0; i_ < expected_.length; i_++) {
            assertEq(expected_[i_], built_[i_]);
        }
    }
}
