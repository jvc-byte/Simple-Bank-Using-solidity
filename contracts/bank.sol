// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./token.sol";

contract JVCBank is Ownable, JVCToken {
    // Declare storage locations
    mapping(address => User) public users;
    uint256 private minDepAmt = 0.00038 ether;
    uint256 private maxWithdAmt = 1 ether;

    // Store user data
    struct User {
        address uAddr;
        string uName;
        uint256 balance;
    }

    // Record the state of the transaction with custom datatype
    enum Status {
        Pending,
        Failed,
        Successful
    }
    Status public status;

    // Log the status of the deposit and withdrawal function
    event DepositSuccessful(address indexed user, uint256 amount);
    event DepositFailed(address indexed user, string message);
    event WithdrawalSuccessful(address indexed addr, address indexed user, uint256 amount);
    event WithdrawalFailed(address indexed user, string message);

    // Verify that an address is not a contract address using the helper function (isContractAddr)
    modifier verifyAddr(address _addr) {
        require(!isContractAddr(_addr), "This is a contract address!");
        _;
    }
    // Verify that a user exist
    modifier findUserByUname(string memory uname) {
        require(bytes(users[msg.sender].uName).length != 0, "User not found!");
        _;
    }

    constructor(uint256 _initialSupply) JVCToken(_initialSupply){}

    // Register users
    function registerUser(string memory uname, address payable addr) public {
        require(bytes(users[addr].uName).length == 0, "User already registered!");
        users[addr] = User(addr, uname, 0);
    }

    // Get a user by Address
    function getUserByAddress(address userAddress) public view verifyAddr(userAddress) returns (User memory) {
        return users[userAddress];
    }

    // Get a user by Username
    function getUserByName(string memory Uname) public view findUserByUname(Uname) returns (User memory) {
        return users[msg.sender];
    }

    // Deposit to the users address
    function deposit() public payable verifyAddr(msg.sender) {
        if (msg.value < minDepAmt) {
            status = Status.Failed;
            emit DepositFailed(msg.sender, "Minimum deposit amount is 0.00038");
            return;
        }
        // Transfer tokens from user to the bank
        transferFrom(payable(msg.sender), address(this), msg.value);
        users[msg.sender].balance += msg.value;
        status = Status.Successful;
        emit DepositSuccessful(msg.sender, msg.value);
    }

    // Withdraw to an external account
    function withdraw(uint256 amount, address payable addr) public payable verifyAddr(msg.sender) {
        require(amount <= users[addr].balance, "Insufficient balance");
        require(amount <= maxWithdAmt, "Withdrawal amount exceeds limit");
        users[addr].balance -= amount;
        transfer(addr, amount);
        emit WithdrawalSuccessful(addr, msg.sender, amount);
    }

    function mintToken(uint256 amount) public {
        mint(address(this), amount);
    }

    function burnToken(uint256 amount) public {
        burn(address(this), amount);
    }

    // Helper function to check if an address is a contract address
    function isContractAddr(address addr_) internal view returns (bool) {
        return addr_.code.length > 0;
    }
}
