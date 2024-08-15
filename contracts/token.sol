// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract JVCToken is ERC20, Ownable {
    constructor(uint256 _initialSupply) ERC20("JVCToken", "JVC") Ownable(msg.sender) {}

    function burn(address fromAddr, uint256 amount) internal virtual onlyOwner {
        _burn(fromAddr, amount);
    }

    function mint(address toAddr, uint256 amount) internal virtual onlyOwner {
        _mint(toAddr, amount);
    }
}
