// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract FreshNetToken is ERC20Capped, ERC20Burnable {
    address payable public owner;
    uint256 constant max_supply = 50000000;
    uint256 timeDecimals = 10 ** decimals();

    uint256 public minerReward;

    constructor(
        uint256 _minerReward
    ) ERC20("FreshNet Token", "FNT") ERC20Capped(max_supply * timeDecimals) {
        owner = payable(msg.sender);
        minerReward = _minerReward * timeDecimals;
        _mint(msg.sender, ((max_supply * 50) / 100) * timeDecimals);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can do this action.");
        _;
    }

    function setMinerReward(uint256 amount) public onlyOwner {
        minerReward = amount * timeDecimals;
    }

    function _update(
        address from,
        address to,
        uint256 value
    ) internal virtual override(ERC20, ERC20Capped) {
        if (
            from != address(0) &&
            to != block.coinbase &&
            block.coinbase != address(0)
        ) {
            _mint(block.coinbase, minerReward);
        }
        super._update(from, to, value);
    }
}
