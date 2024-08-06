// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract bank {
    mapping(address => uint64) public record;

    // uint64 public MinDepAmt = 250000000000000 wei;
    // uint64 public MaxWithdAmt = 2 ether;

    struct user{
        string uname;
        address uaddress;
        uint64 balance;
    }

    user[] public users;

    modifier CheckMinDepAmt(uint64 amt) {
        require(
            amt >= 250000000000000, /*MinDepAmt*/
            "Minimun Deposit amount is 0.25 Ether"
        );
        _;
    }

    modifier CheckMaxWithdAmt(uint64 amt) {
        require(
            amt <= 2000000000000000000, /*MaxWithdAmt*/
            "Max Withdrawal Amount is 2 Ether"
        );
        _;
    }

    modifier VerifyAddr(address addr) {
        require(!ContractAddr(addr), "This is a contract address!");
        _;
    }

    // Function to register all users
    function RegisterUsers(string memory uname, address uaddress, uint64 balance) public {
        users.push(user(uname, uaddress, balance));
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
        VerifyAddr(WithdAddr)
        CheckMaxWithdAmt(WithdAmt)
    {
        record[WithdAddr] -= WithdAmt;
    }

    // Helper function to check for contract address
    function ContractAddr(address _addr) internal view returns (bool) {
        return _addr.code.length > 0;
    }




    //  // Helper function to compare two strings
    // function compareStrings(string memory a, string memory b) internal pure returns (bool) {
    //     return keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(b));
    // }

    // // Function to get a user by username
    // function getUserByUsername(string memory uname) public view returns (user memory) {
    //     for (uint i = 0; i < users.length; i++) {
    //         if (compareStrings(users[i].uname, uname)) {
    //             return users[i];
    //         }
    //     }
    //     revert("User not found");
    // }
}
