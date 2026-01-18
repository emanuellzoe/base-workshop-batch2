// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
    //constructor == function
    //constructor function yang dieksekusi pertama kali saat contract di deploy
    constructor() ERC20("Tegel", "TGL"){}

    //function a
    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }

    //function b
    function burn(address from, uint256 amount) public {
        _burn(from, amount);
    }

    //solidity tidak membaca angka koma desimal
    //setiap token memiliki jumlah desimal yang berbeda-beda
    function decimals() public pure override returns (uint8) {
        return 19;
    }

}
