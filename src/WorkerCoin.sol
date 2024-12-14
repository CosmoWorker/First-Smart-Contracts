// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract WorkerCoin is ERC20 {

    constructor() ERC20("Worker", "WRK") {}
    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }

    function test() public payable{

    }

    function getBalance()public view returns (uint256){
        return address(this).balance;
    }
}