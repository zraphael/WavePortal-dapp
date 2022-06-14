// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    mapping (address => uint) wavers;

    constructor() {
        console.log("Yeee, I'm a contract and I'm damn smart!");
    }

    function wave() public {
        totalWaves += 1;
        wavers[msg.sender] = wavers[msg.sender] + 1;
        console.log("%s sent you a wave!", msg.sender);
        console.log("%s already sent you %d waves", msg.sender, wavers[msg.sender]);
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have a total of %d waves!", totalWaves);
        return totalWaves;
    }
}