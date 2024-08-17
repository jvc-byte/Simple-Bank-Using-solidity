# JVCToken Bank

## Overview

This project includes Solidity smart contracts for a decentralized bank that operates using a custom ERC-20 token, JVCToken, as its official currency. The bank contract allows user registration, token minting, burning, ownership transfer, deposits, and withdrawals. The JVCToken contract manages token minting, transferring, and burning, and provides token-related information.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
  - [Deploying the Contracts](#deploying-the-contracts)
  - [Registering Users](#registering-users)
  - [Depositing and Withdrawing Tokens](#depositing-and-withdrawing-tokens)
- [Contract Details](#contract-details)
  - [Bank Contract](#bank-contract)
  - [JVCToken Contract](#jvctoken-contract)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## Introduction

The JVCToken Bank is a decentralized application (dApp) where users can manage their funds using the custom ERC-20 token JVCToken. The bank supports user registration, token management (minting, burning, ownership transfer), and secure token-based transactions.

## Features

- **Custom ERC-20 Token**: JVCToken, a fully compliant ERC-20 token, used as the official currency.
- **User Management**: Register users and manage their token balances.
- **Token Minting**: Mint new tokens to the bank or other users.
- **Secure Transactions**: Safeguard deposits and withdrawals with built-in checks and balances.

## Getting Started

### Prerequisites
- [Remix IDE](https://remix.ethereum.org/)
- [Metamask](https://metamask.io/)

### Installation

1. **Clone the repository:** Check [here](https://medium.com/@jvc-byte/how-to-clone-a-github-repository-in-remix-ide-two-steps-218d820824b1) for how to clone repository on Remix IDE.

## Usage

### Deploying the Contracts

1. **Deploy the contracts:** Deploy the contract on remix IDE on sepolia testnet using injected provider - Metamask 

3. **Interact with the contracts:** You can interact with the contracts right there on remix IDE.

### Registering Users

- Users can register by calling the `registerUser` function in the `Bank` contract. The function automatically checks the user's token balance and records it.

### Depositing and Withdrawing Tokens

- Users can deposit tokens from their account to the bank using the `deposit` function.
- Users can withdraw tokens from the bank to their account using the `withdraw` function.

## Contract Details

### Bank Contract

- **Functions**:
  - `registerUser`: Registers a new user and records their token balance.
  - `deposit`: Deposits tokens into the user's bank account.
  - `withdraw`: Withdraws tokens from the user's bank account.
  - `getUserByAddress`: Returns the user's information based on their address.
  - `mintToken`: Mints new tokens to the bank's address.
  - `burnToken`: Burns tokens from the bank's address.
  - `changeOwnership`: Changes the ownership of the bank.
  - `getContractBalance`: Returns the token balance of the bank contract.
  - `getBalanceOf`: Returns the token balance of a specified user.
  - `isContractAddr`: Checks if a given address is a contract address.

### JVCToken Contract

- **Functions**:
  - `mint`: Mints new tokens to the specified address.
  - `burn`: Burns tokens from a specified address.
  - `transfer`: Transfers tokens between addresses.
  - `checkBalanceOf`: Returns the token balance of a specified address.
  - `tokenInfo`: Returns the total supply, name, decimals, and symbol of the token.
  - `_update`: Handles the internal logic for minting, burning, and transferring tokens.

## Contributing

Any form of contributions are welcome!

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact

- **Author**: JVC-Byte
- **Email**: [Send a mail](mailto:jvc8463@gmail.com)
- **GitHub**: [jvc-byte](https://github.com/jvc-byte)

---
