// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/utils/Context.sol";
import "./JVCToken.sol";

interface Owner {}

contract Bank is Owner, Context {
    // variable to reference instances of the token contract.
    JVCToken public token;

    // Declare storage locations
    address private _owner;
    mapping(address => User) public users;
    uint256 private minDepAmt = 0.00038 ether;
    uint256 private maxWithdAmt = 1 ether;

    // The owner is not a valid owner account. (eg. `address(0)`)
    error OwnableInvalidOwner(address owner);
    // The caller account is not authorized to perform an operation.
    error OwnableUnauthorizedAccount(address account);

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
    event DepositSuccessful(
        address indexed user,
        uint256 amount
    );
    event DepositFailed(
        address indexed user,
        string message
    );
    event WithdrawalSuccessful(
        address indexed addr,
        address indexed user,
        uint256 amount
    );
    event WithdrawalFailed(
        address indexed user,
        string message
    );
    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    // Throws if called by any account other than the owner.
    modifier onlyOwner() {
        _checkOwner();
        _;
    }

    // Verify that an address is not a contract address using the helper function (isContractAddr)
    modifier verifyAddr(address _addr) {
        require(
            !isContractAddr(_addr),
            "This is a contract address!"
        );
        _;
    }
    // Verify that a user exist
    modifier findUserByUname(string memory uname) {
        require(
            bytes(users[msg.sender].uName).length != 0,
            "User not found!"
        );
        _;
    }

    constructor(address _tokenAddress, address initialOwner)
    {
        token = JVCToken(_tokenAddress);

        if (initialOwner == address(0)) {
            revert OwnableInvalidOwner(address(0));
        }
        _transferOwnership(initialOwner);
    }

    /** Returns the address of the current owner. */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /** Throws if the sender is not the owner.**/
    function _checkOwner() internal view virtual {
        if (owner() != _msgSender()) {
            revert OwnableUnauthorizedAccount(_msgSender());
        }
    }

    /**
     * Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby disabling any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    /**
     * Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        if (newOwner == address(0)) {
            revert OwnableInvalidOwner(address(0));
        }
        _transferOwnership(newOwner);
    }

    /**
     *Transfers ownership of the contract to a new account (`newOwner`).
     * Internal function without access restriction.
     */
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }

    // Register users
    function registerUser(
        string memory uname,
        address payable addr
    ) public {
        require(
            bytes(users[addr].uName).length == 0,
            "User already registered!"
        );
        users[addr] = User(addr, uname, 0);
    }

    // Get a user by Address
    function getUserByAddress(address userAddress)
        public
        view
        verifyAddr(userAddress)
        returns (User memory)
    {
        return users[userAddress];
    }

    // Get a user by Username
    function getUserByName(string memory Uname)
        public
        view
        findUserByUname(Uname)
        returns (User memory)
    {
        return users[msg.sender];
    }

    // Deposit to the users address
    function deposit()
        public
        payable
        verifyAddr(msg.sender)
    {
        if (msg.value < minDepAmt) {
            status = Status.Failed;
            emit DepositFailed(
                msg.sender,
                "Minimum deposit amount is 0.00038"
            );
        } else {
            users[msg.sender].balance += msg.value;
            status = Status.Successful;
            emit DepositSuccessful(msg.sender, msg.value);
        }
    }

    // Withdraw to an external account
    function withdraw(uint256 amount, address payable addr)
        public
        payable
        verifyAddr(msg.sender)
    {
        require(
            amount <= users[addr].balance,
            "Insufficient balance"
        );
        require(
            amount <= maxWithdAmt,
            "Withdrawal amount exceeds limit"
        );

        users[addr].balance -= amount;
        addr.transfer(amount);
        emit WithdrawalSuccessful(addr, msg.sender, amount);
    }

    // Helper function to check if an address is a contract address
    function isContractAddr(address addr_)
        internal
        view
        returns (bool)
    {
        return addr_.code.length > 0;
    }
}
