// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

interface IERC20 {
    function transfert(address to, uint256 amount) external returns (bool);
    function balanceOf(address account) external view return (uint256);
}