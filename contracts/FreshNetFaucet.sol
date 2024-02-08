// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "./interfaces/IERC20";

contract FreshNetFaucet {
    IERC20 public token;
    address payable owner;

    uint256 timeDecimals = 10 ** decimals();
    uint256 public withdrawalAmount = 5 * timeDecimals;
    uint256 public lockTime = 1 minutes;

    mapping (address => uint256) nextWithdrawalTime;

    constructor(address tokenAddress) payable {
        owner = payable(msg.sender);
        token = IERC20(tokenAddress);
    }

    function requestFaucet() public {
        require(msg.sender != address(0), "Must call from a valid address");
        require(token.balanceOf(address(this)) >= withdrawalAmount, "No more faucet to withdraw.");
        require(block.timestamp >= nextWithdrawalTime[msg.sender], "Insufficient time elapsed since the last withdrawal");

        nextWithdrawalTime[msg.sender] = block.timestamp + lockTime;
        token.transfert(address(msg.sender), withdrawalAmount);
    }
}
