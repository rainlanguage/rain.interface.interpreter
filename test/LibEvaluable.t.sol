// SPDX-License-Identifier: CAL
pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import "../src/LibEvaluable.sol";
import "./LibEvaluableSlow.sol";

contract LibEvaluableTest is Test {
    using LibEvaluable for Evaluable;

    function testHashDifferent(Evaluable memory a_, Evaluable memory b_) public {
        vm.assume(a_.interpreter != b_.interpreter || a_.store != b_.store || a_.expression != b_.expression);
        assertTrue(a_.hash() != b_.hash());
    }

    function testHashSame(Evaluable memory a_) public {
        Evaluable memory b_ = Evaluable(a_.interpreter, a_.store, a_.expression);
        assertEq(a_.hash(), b_.hash());
    }

    function testHashSensitivity(Evaluable memory a_, Evaluable memory b_) public {
        vm.assume(a_.interpreter != b_.interpreter && a_.store != b_.store && a_.expression != b_.expression);

        Evaluable memory c_;

        assertTrue(a_.hash() != b_.hash());

        // Check interpreter changes hash.
        c_ = Evaluable(b_.interpreter, a_.store, a_.expression);
        assertTrue(a_.hash() != c_.hash());

        // Check store changes hash.
        c_ = Evaluable(a_.interpreter, b_.store, a_.expression);
        assertTrue(a_.hash() != c_.hash());

        // Check expression changes hash.
        c_ = Evaluable(a_.interpreter, a_.store, b_.expression);
        assertTrue(a_.hash() != c_.hash());

        // Check match.
        c_ = Evaluable(a_.interpreter, a_.store, a_.expression);
        assertEq(a_.hash(), c_.hash());

        // Check hash doesn't include extraneous data
        uint256 v0_ = type(uint256).max;
        uint256 v1_ = 0;
        Evaluable memory d_ = Evaluable(IInterpreterV1(address(0)), IInterpreterStoreV1(address(0)), address(0));
        assembly {
            mstore(mload(0x40), v0_)
        }
        bytes32 hash0_ = d_.hash();
        assembly {
            mstore(mload(0x40), v1_)
        }
        bytes32 hash1_ = d_.hash();
        assertEq(hash0_, hash1_);
    }

    function testEvaluableHashGas0() public pure {
        Evaluable(IInterpreterV1(address(0)), IInterpreterStoreV1(address(0)), address(0)).hash();
    }

    function testEvaluableHashGasSlow0() public pure {
        LibEvaluableSlow.hashSlow(
            Evaluable(IInterpreterV1(address(0)), IInterpreterStoreV1(address(0)), address(0))
        );
    }

    function testEvaluableReferenceImplementation(Evaluable memory evaluable_) public {
        assertEq(LibEvaluable.hash(evaluable_), LibEvaluableSlow.hashSlow(evaluable_));
    }
}
