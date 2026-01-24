// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract TabunganBersama {
    error AmountIsZero();
    address public token;

    constructor(address _token) {
        token = _token;
    }

    function deposit(uint256 _amount) public {
        if (_amount == 0) { revert AmountIsZero(); 
        uint256 shares = 0;

        if (totalSupply)
        }
    }
}