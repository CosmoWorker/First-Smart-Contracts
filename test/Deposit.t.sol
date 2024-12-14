// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Deposit.sol";

contract TestDeposit is Test{
    Deposit c;

    function setUp()public{
        c=new Deposit();
        vm.deal(address(this), 2 ether);
    }

    function testDeposit()public {
        c.deposit{value: 2 ether}();
    }

    function testFailDeposit() public{
        vm.expectRevert("Deposit is less than 1 ether(minimum Deposit)");
        c.deposit{value: 0.5 ether}();
    }

}