// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;
import "@openzeppelin/contracts/access/Ownable.sol";

contract JVCToken is Ownable {
    // Address as key to access users balance
    mapping(address => uint256) internal balances;

    // State variables to store token meta data
    uint256 public totalSupply;
    string public name;
    uint8 public decimals;
    string public symbol;

    // initializer
    constructor() Ownable(msg.sender) {
        balances[msg.sender] = 10;
        totalSupply = balances[msg.sender];
        name = "JVCToken";
        decimals = 18;
        symbol = "JVC";
    }

    // event to log transfer status
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    // Helper function to fetch meta data of the token
    function tokenInfo()
        external
        virtual
        returns (
            uint256,
            string memory,
            string memory,
            uint256
        )
    {
        return (totalSupply, name, symbol, decimals);
    }

    // Transfer from the person initiating the transaction to the provided address
    function transfer(address payable _to, uint256 _value) external payable virtual returns (bool success) {
        require(balances[msg.sender] >= _value, "token balance is lower than the value requested");
        require(msg.sender != _to, "Hold on, you wan deposit to yourself. Dey play!");
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value); //solhint-disable-line indent, no-unused-vars
        return true;
    }

    // Check balance of a given address
    function checkBalanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }

    // Burn some JVCToken
    function burn(address account, uint256 value) external virtual onlyOwner {
        require(account != address(0), "Invalid account!");
        _update(account, address(0), value);
    }

    // Mint more JVCToken
    function mint(address account, uint256 value) external virtual onlyOwner {
        require(account != address(0), "Invalid address");
        _update(address(0), account, value);
    }

    // Helper function to mint or burn a token
    function _update(
        address from,
        address to,
        uint256 value
    ) internal virtual {
        if (from == address(0)) {
            totalSupply += value;
        } else {
            uint256 fromBalance = balances[from];
            require(fromBalance > value, "Insufient JVC token");
            unchecked {
                balances[from] = fromBalance - value;
            }
        }

        if (to == address(0)) {
            unchecked {
                totalSupply -= value;
            }
        } else {
            unchecked {
                balances[to] += value;
            }
        }
        emit Transfer(from, to, value);
    }
}
