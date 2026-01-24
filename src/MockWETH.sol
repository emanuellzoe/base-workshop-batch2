// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";



contract M is ERC20, Ownable {
    error ERC20ExceedsMaxMintAmount(uint256 amount);
    //constructor == function
    //constructor function yang dieksekusi pertama kali saat contract di deploy

    //mint = buat token baru
    //burn = hancurkan token yang sudah ada, untuk mengurangi jumlah token yang beredar
    constructor() ERC20("Tegel", "TGL") Ownable(msg.sender) {}

    modifier maxMint(uint256 _amount) {
        if (_amount > 1_000e19) revert ERC20ExceedsMaxMintAmount(_amount);         
        _;
    }

    //function a
    function mint(address to, uint256 amount) public onlyOwner maxMint(amount) {
        _mint(to, amount);
    }

    //function b
    function burn(address from, uint256 amount) public {
        _burn(from, amount);
    }

    //solidity tidak membaca angka koma desimal
    //setiap token memiliki jumlah desimal yang berbeda-beda
    //default OpenZeppelin adalah 18
    //functioin decimals jika public baru bisa dicheck menggunakan website seperti etherscan
    function decimals() public pure override returns (uint8) {
        return 18;
    }

}
