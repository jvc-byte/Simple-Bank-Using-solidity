// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    constructor(string memory name, string memory symbol)
        ERC20(name, symbol)
    {
        // Mint 100 tokens to msg.sender with default 18 decimals
        _mint(msg.sender, 100 * 10 ** uint256(decimals()));
    }
}
