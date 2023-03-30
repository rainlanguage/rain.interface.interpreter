// SPDX-License-Identifier: CAL
pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import "../src/LibEncodedDispatch.sol";

contract LibEncodedDispatchTest is Test {
    function testRoundTrip(address expression_, SourceIndex sourceIndex_, uint16 maxOutputs_) public {
        (address expressionDecoded_, SourceIndex sourceIndexDecoded_, uint16 maxOutputsDecoded_) =
            LibEncodedDispatch.decode(LibEncodedDispatch.encode(expression_, sourceIndex_, maxOutputs_));
        assertEq(expression_, expressionDecoded_);
        assertEq(SourceIndex.unwrap(sourceIndex_), SourceIndex.unwrap(sourceIndexDecoded_));
        assertEq(maxOutputs_, maxOutputsDecoded_);
    }
}
