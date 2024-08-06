// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract bank {
    mapping(address => uint64) public record;
    mapping(string => User) private users;

    uint64 private MinDepAmt = 250000000000000 wei;
    uint64 private MaxWithdAmt = 2 ether;

    struct User {
        string uname;
        address uaddress;
        uint64 balance;
    }

    modifier CheckMinDepAmt(uint64 amt) {
        require(amt >= MinDepAmt, "Minimun Deposit amount is 0.25 Ether");
        _;
    }

    modifier CheckMaxWithdAmt(uint64 amt) {
        require(amt <= MaxWithdAmt, "Max Withdrawal Amount is 2 Ether");
        _;
    }

    modifier VerifyAddr(address addr) {
        require(!ContractAddr(addr), "This is a contract address!");
        _;
    }
    // Check if user exist in the system
    modifier VerifyUname(string memory uname) {
        require(users[uname].uaddress != address(0), "User does not exist!");
        _;
    }

    // Function to register a user
    function registerUser(
        string memory uname,
        address uaddress,
        uint64 balance
    ) public {
        users[uname] = User(uname, uaddress, balance);
    }

    // Function to get a user by username
    function getUserByUsername(string memory uname)
        public
        view
        VerifyUname(uname)
        returns (User memory)
    {
        return users[uname];
    }

    // set a minimum amount for deposit
    function deposit(address DepAddr, uint64 DepAmt)
        public
        VerifyAddr(DepAddr) // ensure the caller is not a contract address
        CheckMinDepAmt(DepAmt)
    {
        record[DepAddr] += DepAmt;
    }

    // set a maximum amount for withdrawal (withdrawal limit)
    function withdraw(address WithdAddr, uint64 WithdAmt)
        public
        VerifyAddr(WithdAddr) // ensure the caller is not a contract address
        CheckMaxWithdAmt(WithdAmt)
    {
        record[WithdAddr] -= WithdAmt;
    }

    // Helper function to check for contract address
    function ContractAddr(address _addr) internal view returns (bool) {
        return _addr.code.length > 0;
    }
}
