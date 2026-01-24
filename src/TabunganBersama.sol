// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {IERC20} from "@openzeppelin/token/ERC20/IERC20.sol";
import {Ownable} from "@openzeppelin/access/Ownable.sol";
import {ReentrancyGuard} from "@openzeppelin/security/ReentrancyGuard.sol";
import {SafeERC20} from "@openzeppelin/token/ERC20/utils/SafeERC20.sol"; //

contract TabunganBersama is Ownable {
    using SafeERC20 for IERC20;
    // safe

    error AmountIsZero();
    error InsufficientBalance();

    address public token;

    uint256 public totalSupplyShares;
    uint256 public totalSupplyAssets;

    mapping(address => uint256) public userSupplyShares;

    constructor(address _token) {
        token = _token;
    }

    function deposit(uint256 _amount) public {
        if (_amount == 0) revert AmountIsZero();
        uint256 shares = 0;

        if (totalSupplyShares == 0) {
            shares = _amount;
        } else {
            shares = _amount * totalSupplyShares / totalSupplyAssets;
        }

        IERC20(token).transferFrom(msg.sender, address(this), _amount);

        userSupplyShares[msg.sender] += shares;
        totalSupplyShares += shares;
        totalSupplyAssets += _amount;
    }

    function withdraw(uint256 _shares) public {
        if (_shares == 0) revert AmountIsZero();
        if (userSupplyShares[msg.sender] < _shares) revert InsufficientBalance();

        uint256 amount = _shares * totalSupplyAssets / totalSupplyShares;

        userSupplyShares[msg.sender] -= _shares;
        totalSupplyShares -= _shares;
        totalSupplyAssets -= amount;

        IERC20(token).transfer(msg.sender, amount);
    }

    function distributeYield(uint256 _amount) public {
        totalSupplyAssets += _amount;

        IERC20(token).safetransferFrom(msg.sender, address(this), _amount);
    }

    
}