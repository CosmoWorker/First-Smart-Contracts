// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Admin.sol";

contract TestAdmin is Test{
    Admin c;
    address newAdmin=0x96848450eB07743FF280067Aef6ea1a8d91E4037;
    address nonAdmin=0x29C083d424Bbe8b0f2DE0608B05D4BDFaa60CFd5;

    function setUp()public {
        c=new Admin(address(this));
    }

    function testChangeAdmin()public {
        vm.prank(address(this)); //not really required
        c.changeAdmin(newAdmin);
        assertEq(c.admin(), newAdmin);
    }

    function testFailChangeAdmin()public { //fails with error message
        vm.prank(nonAdmin);
        vm.expectRevert("Only admin can change the admin");
        c.changeAdmin(newAdmin);
    }
}