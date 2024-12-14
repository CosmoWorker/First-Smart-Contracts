// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/RestrictedTransfer.sol";

contract TestRestrictedTransfer is Test{
    RestrictedTransfer c;

    function setUp() public{
        c=new RestrictedTransfer(address(this));
        vm.deal(address(this), 10 ether);
    }

    function testAuthTransfer() public{
        uint256 fee=c.transferFee();
        vm.prank(address(this));
        c.transfer{value: fee}(0x96848450eB07743FF280067Aef6ea1a8d91E4037, 3);
        assertEq(address(0x96848450eB07743FF280067Aef6ea1a8d91E4037).balance, 3, "ok");
    }

    // function testHoaxTransfer() public{
    //     uint256 fee=c.transferFee();
    //     hoax(0x96848450eB07743FF280067Aef6ea1a8d91E4037, 1 ether);
    //     c.transfer{value: fee}(address(0x29C083d424Bbe8b0f2DE0608B05D4BDFaa60CFd5), 3);
    //     assertEq(address(0x96848450eB07743FF280067Aef6ea1a8d91E4037).balance, 4, "ok");
    // }

    function testFailTransfer()public {
        // uint256 fee=c.transferFee();
        vm.prank(0x96848450eB07743FF280067Aef6ea1a8d91E4037);
        c.transfer(address(0x29C083d424Bbe8b0f2DE0608B05D4BDFaa60CFd5), 2);
    }
}