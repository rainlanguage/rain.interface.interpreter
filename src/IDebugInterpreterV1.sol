// SPDX-License-Identifier: CAL
pragma solidity ^0.8.18;

import "./IInterpreterV1.sol";

interface IDebugInterpreterV1 {
    function offchainDebugEval(
        IInterpreterStoreV1 store,
        FullyQualifiedNamespace namespace,
        bytes[] calldata compiledSources,
        uint256[] calldata constants,
        uint256[][] calldata context,
        uint256 stackLength,
        SourceIndex sourceIndex
    ) external view returns (uint256[] calldata stack, uint256[] calldata kvs);
}
