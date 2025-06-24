// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Auction {
    address public highestBidder;
    uint256 public highestBid;
    uint256 public endTime;
    bool public ended;

    event BidPlaced(address indexed bidder, uint256 amount);
    event AuctionEnded(address winner, uint256 amount);

    constructor(uint256 _biddingTime) {
        endTime = block.timestamp + _biddingTime;
    }

    function bid() public payable {
        require(block.timestamp < endTime, "Auction has ended");
        require(msg.value > highestBid, "Bid too low");
        highestBidder = msg.sender;
        highestBid = msg.value;
        emit BidPlaced(msg.sender, msg.value);
    }

    function endAuction() public {
        require(block.timestamp >= endTime, "Auction not yet ended");
        require(!ended, "Auction already ended");
        ended = true;
        emit AuctionEnded(highestBidder, highestBid);
    }
}
