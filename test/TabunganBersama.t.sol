 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Test, console} from "forge-std/Test.sol";
import {TabunganBersama} from "../src/TabunganBersama.sol";
import {IERC20} from "@openzeppelin/token/ERC20/IERC20.sol";

// RUN
// forge test --match-contract TabunganBersamaTest
contract TabunganBersamaTest is Test {
    TabunganBersama public tabunganBersama;

    address public token = 0x18Bc5bcC660cf2B9cE3cd51a404aFe1a0cBD3C22; // IDRX
    address public eth = 0x71041dddad3595F9CEd3DcCFBe3D1F4b0a16Bb70; //eth/usd
    address public usdc = 0x7e860098F58bBFC8648a4311b374B1D669a2bc6B; //usdc/usd


    address public deployer = makeAddr("deployer");
    // address public deployer = 0xaEaC7B054c1D0eE95826abf907c723862E0096F8;
    address public pepeng = makeAddr("pepeng");

    address public alice = makeAddr("alice");
    address public bob = makeAddr("bob");

    function setUp() public {
        vm.createSelectFork(vm.rpcUrl("base_mainnet"));
        // simulasi bahwa deployer seolah2 punya idrx sebanyak (amount)
        deal(token, deployer, 100_000_000_000e2);
        deal(token, alice, 1_000_000e2);
        deal(token, bob, 9_000_000e2);

        tabunganBersama = new TabunganBersama(token);
    }

    // RUN
    // forge test --match-contract TabunganBersamaTest --match-test testCheckBalance -vvv
    function testCheckBalance() public {
        // uint256 tokenBalanceBefore = IERC20(token).balanceOf(deployer);
        // console.log("deployer balance: ", tokenBalanceBefore);
        // simulasi bahwa deployer seolah2 punya idrx sebanyak (amount)
        // deal(token, deployer, 100_000_000_000e2);
        // uint256 tokenBalanceAfter = IERC20(token).balanceOf(deployer);
        // console.log("deployer balance: ", tokenBalanceAfter);

        // console.log("==================");

        // console.log("balance deployer before", IERC20(token).balanceOf(deployer));
        // console.log("balance pepeng before", IERC20(token).balanceOf(pepeng));

        // vm.startPrank(deployer);
        // uint256 amountToTransfer = 19_000_000e2;
        // IERC20(token).approve(pepeng, amountToTransfer);
        // IERC20(token).transfer(pepeng, amountToTransfer);
        // vm.stopPrank();

        // console.log("balance deployer after", IERC20(token).balanceOf(deployer));
        // console.log("balance pepeng after", IERC20(token).balanceOf(pepeng));
    }

    // RUN
    // forge test --match-contract TabunganBersamaTest --match-test testDeposit -vvv
    function testDeposit() public {
        // vm.startPrank(deployer);
        // uint256 amountToTransfer = 19_000_000e2;

        // IERC20(token).approve(address(tabunganBersama), amountToTransfer);
        // tabunganBersama.deposit(amountToTransfer);
        // vm.stopPrank();

        // console.log("tabunganBersama.totalSupplyShares():", tabunganBersama.totalSupplyShares());
        // console.log("tabunganBersama.totalSupplyAssets():", tabunganBersama.totalSupplyAssets());
        // console.log("tabunganBersama.userSupplyShares(deployer):", tabunganBersama.userSupplyShares(deployer));

        // assertEq(tabunganBersama.totalSupplyAssets(), amountToTransfer);

        uint256 amountToTransfer = 1_000_000e2;

        vm.startPrank(alice);
        IERC20(token).approve(address(tabunganBersama), amountToTransfer);
        tabunganBersama.deposit(amountToTransfer);
        vm.stopPrank();

        vm.startPrank(bob);
        IERC20(token).approve(address(tabunganBersama), amountToTransfer);
        tabunganBersama.deposit(amountToTransfer);
        vm.stopPrank();

        console.log("tabunganBersama.totalSupplyShares():", tabunganBersama.totalSupplyShares());
        console.log("tabunganBersama.totalSupplyAssets():", tabunganBersama.totalSupplyAssets());

        console.log("tabunganBersama.userSupplyShares(alice):", tabunganBersama.userSupplyShares(alice));
        console.log("tabunganBersama.userSupplyShares(bob):", tabunganBersama.userSupplyShares(bob));


        // RUN
    // forge test --match-contract TabunganBersamaTest --match-test testWithdraw -vvv
    function testWithdraw() public {
        uint256 amountToTransfer = 1_000_000e2;

        vm.startPrank(alice);
        IERC20(token).approve(address(tabunganBersama), amountToTransfer);
        tabunganBersama.deposit(amountToTransfer);
        vm.stopPrank();

        vm.startPrank(bob);
        IERC20(token).approve(address(tabunganBersama), amountToTransfer);
        tabunganBersama.deposit(amountToTransfer);
        vm.stopPrank();

        vm.startPrank(alice);
        tabunganBersama.withdraw(amountToTransfer / 2);
        vm.stopPrank();

        console.log("tabunganBersama.totalSupplyShares():", tabunganBersama.totalSupplyShares());
        console.log("tabunganBersama.totalSupplyAssets():", tabunganBersama.totalSupplyAssets());

        console.log("tabunganBersama.userSupplyShares(alice):", tabunganBersama.userSupplyShares(alice));
        console.log("tabunganBersama.userSupplyShares(bob):", tabunganBersama.userSupplyShares(bob));
    }

    // RUN
    // forge test --match-contract TabunganBersamaTest --match-test testDistributeYieldWithWithdraw -vvv
    function testDistributeYieldWithWithdraw() public {
        uint256 amountToTransfer1 = 1_000_000e2;
        uint256 amountToTransfer2 = 9_000_000e2;

        uint256 amountToDistribute = 2_000_000e2;

        vm.startPrank(alice);
        IERC20(token).approve(address(tabunganBersama), amountToTransfer1);
        tabunganBersama.deposit(amountToTransfer1);
        vm.stopPrank();

        vm.startPrank(bob);
        IERC20(token).approve(address(tabunganBersama), amountToTransfer2);
        tabunganBersama.deposit(amountToTransfer2);
        vm.stopPrank();

        vm.startPrank(deployer);
        IERC20(token).approve(address(tabunganBersama), amountToDistribute);
        tabunganBersama.distributeYield(amountToDistribute);
        vm.stopPrank();

        console.log("alice balance before:", IERC20(token).balanceOf(alice));

        vm.startPrank(alice);
        tabunganBersama.withdraw(1_000_000e2);
        vm.stopPrank();

        console.log("alice dapat berapa?");

        console.log("alice balance after:", IERC20(token).balanceOf(alice));
    }
    
}
}