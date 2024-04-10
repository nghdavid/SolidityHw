// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
contract Auction {
    address public winningAddress; 
    uint256 public AUCTION_DEADLINE;
    mapping(address => uint256) public bids;
    address[] private bidders; // To keep track of who has bid
    //TODO: You may add any other variables here, if necessary.
    constructor() {
      // AUCTION_DEADLINE = block.timestamp + 30 days;
      AUCTION_DEADLINE = block.timestamp + 2 minutes;
    }
    // Ignore any bids that are submitted when block.timestamp is greater than AUCTION_DEADLINE
    function submitBid(uint amount) public {
      require(block.timestamp <= AUCTION_DEADLINE, "Auction has ended.");
      bids[msg.sender] = amount;
      bidders.push(msg.sender);
    }
    // sets winningAddress to the address that called submitBid(uint amount) with the highest input amount
    // Do not allow winningAddress to be set at a time before AUCTION_DEADLINE
    function calculateWinner() public { 
      require(block.timestamp > AUCTION_DEADLINE, "Auction has not ended.");
      uint256 highestBid = 0;
      for (uint i = 0; i < bidders.length; i++) {
        if (bids[bidders[i]] > highestBid) {
          highestBid = bids[bidders[i]];
          winningAddress = bidders[i];
        }
      }
    } 
}