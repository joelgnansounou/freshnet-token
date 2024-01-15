// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract FreshNetToken is ERC20Capped, ERC20Burnable {
    uint256 constant max_supply = 50000000;
    uint256 timeDecimals = 10 ** decimals();

    constructor()
        ERC20("FreshNet Token", "FNT")
        ERC20Capped(max_supply * timeDecimals)
    {
        _mint(msg.sender, ((max_supply * 50) / 100) * timeDecimals);
    }
}
