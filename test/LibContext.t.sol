// SPDX-License-Identifier: CAL
pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import "../src/LibContext.sol";
import "./LibContextSlow.sol";

contract LibContextTest is Test {
    function testBase() public {
        uint256[] memory baseContext_ = LibContext.base();

        assertEq(baseContext_.length, 2);
        assertEq(baseContext_[0], uint256(uint160(msg.sender)));
        assertEq(baseContext_[1], uint256(uint160(address(this))));
        assertTrue(msg.sender != address(this));
    }

    function testBuildStructureReferenceImplementation(uint256[][] memory base_) public {
        // @todo support signed context testing, currently fails due to invalid
        // signatures blocking the build process.
        SignedContext[] memory signedContexts_ = new SignedContext[](0);

        uint256[][] memory expected_ = LibContextSlow.buildStructureSlow(base_, signedContexts_);
        uint256[][] memory actual_ = LibContext.build(base_, signedContexts_);
        assertEq(expected_.length, actual_.length);

        for (uint256 i_ = 0; i_ < expected_.length; i_++) {
            assertEq(expected_[i_], actual_[i_]);
        }
    }

    function testBuild0() public {
        // @todo test this better.
        uint256[][] memory expected_ = new uint256[][](1);
        expected_[0] = LibContext.base();
        uint256[][] memory built_ = LibContext.build(new uint256[][](0), new SignedContext[](0));
        assertEq(expected_.length, built_.length);

        for (uint256 i_ = 0; i_ < expected_.length; i_++) {
            assertEq(expected_[i_], built_[i_]);
        }
    }

    function testBuildGas0() public view {
        LibContext.build(new uint256[][](0), new SignedContext[](0));
    }
}
