// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

interface IAPI {
    function requestMultipleParameters() external;

    function USDC() external view returns (uint256);

    function BNB() external view returns (uint256);

    function XRP() external view returns (uint256);

    function SOL() external view returns (uint256);

    function ADA() external view returns (uint256);

    function AVAX() external view returns (uint256);

    function DODGE() external view returns (uint256);

    function DOT() external view returns (uint256);
}
