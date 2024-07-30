// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract SimpleBank {
    // Mapping to store the balance of each user
    mapping(address => uint256) public balances;

    // Event to log deposits
    event Deposit(address indexed user, uint256 amount);

    // Event to log withdrawals
    event Withdrawal(address indexed user, uint256 amount);

    // Function to deposit Ether into the contract
    function deposit() public payable {
        // Increase the balance of the sender by the deposited amount
        balances[msg.sender] += msg.value;

        // Emit the Deposit event
        emit Deposit(msg.sender, msg.value);
    }

    // Function to withdraw Ether from the contract
    function withdraw(uint256 amount) public {
        // Check if the sender has enough balance to withdraw
        require(balances[msg.sender] >= amount, "Insufficient balance");

        // Decrease the balance of the sender
        balances[msg.sender] -= amount;

        // Transfer the amount to the sender
        payable(msg.sender).transfer(amount);

        // Emit the Withdrawal event
        emit Withdrawal(msg.sender, amount);
    }

    // Function to get the balance of the caller
    function getBalance() public view returns (uint256) {
        return balances[msg.sender];
    }
}
