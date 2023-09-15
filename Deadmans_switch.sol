// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DeadmansSwitch {
    address public owner;
    address public beneficiary;
    uint256 public lastCheckedBlock;
    uint256 public blockThreshold = 10;

    constructor(address _beneficiary) {
        owner = msg.sender;
        beneficiary = _beneficiary;
        lastCheckedBlock = block.number;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    function stillAlive() external onlyOwner {
        lastCheckedBlock = block.number;
    }

    function checkStatus() external {
        require(block.number - lastCheckedBlock > blockThreshold, "Owner hasn't checked in.");
        payable(beneficiary).transfer(address(this).balance);
    }

    receive() external payable {}
}
