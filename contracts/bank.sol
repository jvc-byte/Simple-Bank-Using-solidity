// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract bank {
    mapping (address => uint256) public record;

    function deposit(uint256 amount, address user) public  {
        record [user] += amount;

        // record[user] = record[user] +amount;
    }

    function _deposit() public payable {
        record[msg.sender] += msg.value;
    }
    
    function withdraw() public payable {
        record[msg.sender] -= msg.value;
    }
}