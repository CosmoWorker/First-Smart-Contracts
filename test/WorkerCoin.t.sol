// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "../src/WorkerCoin.sol";

contract TestWorkerCoin is Test {
    event Transfer(address indexed from, address indexed to, uint256 amount);
    event Approval(address indexed from, address indexed to, uint256 amount);
    WorkerCoin c;

    function setUp() public {
        c = new WorkerCoin();
    }

    function testMint() public{
        c.mint(address(this), 100);
        assertEq(c.balanceOf(address(this)), 100, "ok");
        c.mint(0x96848450eB07743FF280067Aef6ea1a8d91E4037, 100);
        assertEq(c.balanceOf(0x96848450eB07743FF280067Aef6ea1a8d91E4037), 100, "ok");
    }

    function testTransfer()public{
        c.mint(address(this), 100);
        c.transfer(0x96848450eB07743FF280067Aef6ea1a8d91E4037, 60);
        assertEq(c.balanceOf(address(this)), 40, "ok");
        assertEq(c.balanceOf(0x96848450eB07743FF280067Aef6ea1a8d91E4037), 60, "ok");
        vm.prank(0x96848450eB07743FF280067Aef6ea1a8d91E4037);
        c.transfer(address(this),60);
        assertEq(c.balanceOf(address(this)), 100, "ok");
        assertEq(c.balanceOf(0x96848450eB07743FF280067Aef6ea1a8d91E4037), 0, "ok");   
    }

    function testApprove()public {
        c.mint(address(this), 100);
        c.approve(0x96848450eB07743FF280067Aef6ea1a8d91E4037, 20);
        assertEq(c.allowance(address(this), 0x96848450eB07743FF280067Aef6ea1a8d91E4037), 20);

        vm.prank(0x96848450eB07743FF280067Aef6ea1a8d91E4037);
        c.transferFrom(address(this), 0x96848450eB07743FF280067Aef6ea1a8d91E4037, 10);
        assertEq(c.balanceOf(address(this)), 90, "ok");
        assertEq(c.balanceOf(0x96848450eB07743FF280067Aef6ea1a8d91E4037), 10, "ok");
        assertEq(c.allowance(address(this), 0x96848450eB07743FF280067Aef6ea1a8d91E4037), 10);
    }

    function testFailMint()public {
        assertEq(c.balanceOf(address(this)), 100);
        c.mint(0x96848450eB07743FF280067Aef6ea1a8d91E4037, 100);
        assertEq(c.balanceOf(0x96848450eB07743FF280067Aef6ea1a8d91E4037), 100);    
    }

    function testFailApprove() public{
        c.mint(address(this), 100);

        c.approve(0x96848450eB07743FF280067Aef6ea1a8d91E4037, 10);
        vm.prank(0x96848450eB07743FF280067Aef6ea1a8d91E4037);
        c.transferFrom(address(this), 0x96848450eB07743FF280067Aef6ea1a8d91E4037, 20);    
    }  

    function testFailTransfer()public{
        c.mint(address(this), 20);
        c.transfer(0x96848450eB07743FF280067Aef6ea1a8d91E4037, 100);
    }

    function testTransferEmit()public {
        c.mint(address(this), 100);
        vm.expectEmit(true, true, false, true);
        emit Transfer(address(this), 0x96848450eB07743FF280067Aef6ea1a8d91E4037, 10);
        c.transfer(0x96848450eB07743FF280067Aef6ea1a8d91E4037, 10);

        //not required
        vm.startPrank(0x96848450eB07743FF280067Aef6ea1a8d91E4037);
        c.transfer(address(this), 5);
        c.transfer(address(this), 5);
        vm.stopPrank();
        c.transfer(0x96848450eB07743FF280067Aef6ea1a8d91E4037, 20);
        assertEq(c.balanceOf(0x96848450eB07743FF280067Aef6ea1a8d91E4037), 20, "ok");
    }

    function testExpectApprove()public {
        c.mint(address(this), 100);
        vm.expectEmit(true, true, false, true);
        emit Approval(address(this), 0x96848450eB07743FF280067Aef6ea1a8d91E4037, 10);
        c.approve(0x96848450eB07743FF280067Aef6ea1a8d91E4037, 10);
        vm.prank(0x96848450eB07743FF280067Aef6ea1a8d91E4037);
        c.transferFrom(address(this), 0x96848450eB07743FF280067Aef6ea1a8d91E4037, 10);
    }

    function testDealExample()public{
        address account=0x96848450eB07743FF280067Aef6ea1a8d91E4037;
        vm.deal(account, 10 ether);
        //native token only--^
        assertEq(address(account).balance, 10 ether);
    }

    function testHoaxExample()public{
        hoax(0x96848450eB07743FF280067Aef6ea1a8d91E4037, 100 ether);
        c.test{value: 100 ether}();
        assertEq(c.getBalance(), 100 ether, "ok");

    }

}


