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

    event FaucetFunded(address account, uint256 amount);

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

    function fund() public payable {
        emit FaucetFunded(msg.sender, msg.value);
    }

    function getBalance() public view return (uint256) {
        return token.balanceOf(address(this));
    }

    function setWithdrawalAmount(uint256 amount) public onlyOwner {
        withdrawalAmount = amount * timeDecimals;
    }

    function setLockTime(uint256 time) public onlyOwner {
        lockTime = time * 1 minutes;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can do this action.");
        _;
    }
}
