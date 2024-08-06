// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Bank {
    // Struct to store user profile information
    struct UserProfile {
        string name;     // User's name
        address userAddress; // User's address
        uint256 balance; // User's balance
    }

    // Mapping from user address to user profile
    mapping (address => UserProfile) public userProfiles;

    // Minimum deposit amount set to 1 ether
    uint256 public constant MIN_DEPOSIT = 1 ether;

    // Maximum withdrawal limit set to 5 ether
    uint256 public constant MAX_WITHDRAWAL = 5 ether;

    // Function to create or update a user's profile
    function setUserProfile(string memory _name) public {
        userProfiles[msg.sender].name = _name;
        userProfiles[msg.sender].userAddress = msg.sender;
    }

    // Set a minimum amount for deposit
    function deposit(uint256 amount) public {
        require(amount >= MIN_DEPOSIT, "Deposit amount is too small.");
        userProfiles[msg.sender].balance += amount;
    }

    // Deposit function using payable for receiving ether
    function _deposit() public payable {
        require(msg.value >= MIN_DEPOSIT, "Deposit amount is too small.");
        userProfiles[msg.sender].balance += msg.value;
    }

    // Set a maximum amount for withdrawal (withdrawal limit)
    function withdraw(uint256 _amount) public {
        require(_amount <= MAX_WITHDRAWAL, "Withdrawal amount exceeds the maximum limit.");
        require(userProfiles[msg.sender].balance >= _amount, "Insufficient balance.");
        userProfiles[msg.sender].balance -= _amount;
        payable(msg.sender).transfer(_amount);
    }

    // Function to get a user's profile information
    function getUserProfile(address _user) public view returns (string memory, address, uint256) {
        UserProfile memory user = userProfiles[_user];
        return (user.name, user.userAddress, user.balance);
    }
}