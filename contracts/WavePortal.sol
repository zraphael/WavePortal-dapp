// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    uint256 seed;

    event NewWave(address indexed from, uint256 timestamp, string message);

    struct Wave {
        address waver;
        string message;
        uint256 timestamp;
    }

    Wave[] waves;

    mapping(address => uint) wavers;
    mapping(address => uint256) public lastWavedAt;

    constructor() payable {
        console.log("Yeee, I'm a contract and I'm damn smart!");
        seed = (block.timestamp + block.difficulty) % 100;
    }

    function wave(string memory _message) public {
        require(
            lastWavedAt[msg.sender] + 1 seconds < block.timestamp,
            "Wait 30 seconds before sending another wave."
        );

        lastWavedAt[msg.sender] = block.timestamp;

        totalWaves += 1;
        wavers[msg.sender] = wavers[msg.sender] + 1;
        console.log("%s waved with the following message: %s", msg.sender, _message);

        waves.push(Wave(msg.sender, _message, block.timestamp));

        seed = (block.difficulty + block.timestamp + seed) % 100;

        if(seed <= 50) {
            console.log("%s won!", msg.sender);

            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than the contract actually have."
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed in withdrawing money from the contract.");
        }

        emit NewWave(msg.sender, block.timestamp, _message);
    }

    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have a total of %d waves!", totalWaves);
        return totalWaves;
    }
}