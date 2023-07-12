//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

function getRateBPS(uint256 bps) pure returns (uint256) {
    uint256 a = bps * uint256(1e14);
    uint256 b = uint256(365 days);
    return a / b;
}

function getRateAPY(uint256 apy) pure returns (uint256) {
    uint256 a = apy * uint256(1e16);
    uint256 b = uint256(365 days);
    return a / b;
}

function memDump() pure {
    assembly {
        mstore(0x0, 0x00)
        mstore(0x20, 0x20)
    }
}
