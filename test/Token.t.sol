// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;
import {Test, console} from "forge-std/Test.sol";
import {Token} from "../src/Token.sol";


contract TokenTest is Test {
    Token public token;

    address alice = makeAddr("alice");
    address bob = makeAddr("bob");

    function setUp() public {
        token = new Token();
    }

    function testName() public {
        assertEq(token.name(), "Tegel");
    }

    function testSymbol() public view {
        assertEq(token.symbol(), "TGL");
    }

    function testDecimals() public view {
        assertEq(token.decimals(), 19);
    }

    function testMint() public {
        token.mint(alice, 1e19);
        assertEq(token.balanceOf(alice), 1e19);
    }
    function testBurn() public {
        token.mint(alice, 1e19);
        token.burn(alice, 1e19);
        assertEq(token.balanceOf(alice), 0);
    }
    function testTranfer() public {
        //alice punya token 1000 dan bob itu tidak memiliki token
        //alice tranfer 500 token ke bob
        token.mint(alice, 1000e19);
        vm.startPrank(alice);
        token.transfer(bob, 500e19);
        vm.stopPrank();

        console.log("Alice balance:", token.balanceOf(alice));
        console.log("Bob balance:", token.balanceOf(bob));
    }
}