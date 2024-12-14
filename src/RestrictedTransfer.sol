// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract RestrictedTransfer {
    address public authorized;
    uint256 public transferFee = 1 ether;

    constructor(address _authorized) {
        authorized = _authorized;
    }

    function transfer(address to, uint256 amount) external payable {
        require(msg.sender == authorized, "Only authorized can transfer");
        require(msg.value >= transferFee, "Insufficient fee");

        payable(to).transfer(amount);
    }
}