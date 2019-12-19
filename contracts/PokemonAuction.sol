// pragma solidity ^0.5.12;
// import "./PokemonBase.sol";
// import "../node_modules/@openzeppelin/contracts/access/Roles.sol";
// import "../node_modules/@openzeppelin/contracts/GSN/Context.sol";


// contract PokeonAuction  {
//     SaleAuction public saleAuction;

//     function setSaleAuctionAddress(address _address) external {
//         SaleAuction candidateContract = SaleClockAuction(_address);
//         // Set the new contract address
//         saleAuction = candidateContract;
//     }
//     mapping(address => uint) pendingWithdrawals;
//     function deposit() external payable {
//         require(msg.value > 0);
//         pendingWithdrawals[_msgSender()] += msg.value;
//         // emit event;
//     }
//     function withdraw() public {
//         uint amount = pendingWithdrawals[msg.sender];
//         require(amount>0);
//         // Remember to zero the pending refund before
//         // sending to prevent re-entrancy attacks
//         pendingWithdrawals[msg.sender] = 0;
//         msg.sender.transfer(amount);
//     }


//     mapping(uint256 => Auction) private tokenIdToAuction;
//     struct Auction {
//         uint256 tokenId;
//         address seller;
//         uint128 price;
//     }

//     function createAuction(uint256 _id,uint128 _price) public {
//         require(_msgSender() == ownerOf(_id)," you are not the owner of this pokemon");
//         // already オークションされてるか確認　isOnAuction

//         Auction memory auction = Auction({
//             tokenId:_id,
//             seller:_msgSender(),
//             price:_price
//         });
//         require(!_isOnAuction(auction),"");

//         //escrow : ownerからこのコントラクトに所有権を移す．
//         tokenIdToAuction[_id] = auction;
//         safeTransferFrom(_msg.Sender(), address(this), _id);
//         // Emit events

//     }

//     function _buy(address to, uint256 _tokenId) internal {
//         Auction memory auction = tokenIdToAuction[_tokenId];
//         require(_isOnAuction(auction),"");

//         address seller = auction.seller;
//         uint128 price = auction.price;

//         // 手数料を販売額から奪う＝＞販売者の売り上げのぶんだけ残高を増やす
//         // require "Is auction held" tokenidのオークションがやってるか
//         // require("already someone is approved"確認 )
//         // require(msg.value >=  price,"");
//         // or below
//         require(pendingWithdrawals[_msgSender()] >= price,"");
//         // compute  fee  float??
//         uint256 sellerProceeds = price * 0.1;
//         // uint256 change = msg.value - price;
//         // Remove Auction return true if succeed.

//         _removeAuction(_tokenId);
//         pendingWithdrawals[_msgSender()] -= price;
//         pendingWithdrawals[seller] += sellerProceeds;
//         // this contract receive the fee 

//         // owner is this contract ,so the contract is able to  call safeTransferFrom
//         pokemons[_tokenId].previousOwner.push(seller);
//         safeTransferFrom(address(this),_msg.Sender(), _tokenId);
//         // msg.sender.transfer(change);
//     }

//     /// @dev Removes an auction from the list of open auctions.
//     /// @param _tokenId - _id of NFT on auction.
//     function _removeAuction(uint256 _tokenId) internal {
//         delete tokenIdToAuction[_tokenId];
//     }

//     /// @dev Returns true if the NFT is on auction.
//     /// @param _auction - Auction to check.
//     function _isOnAuction(Auction storage _auction) internal view returns (bool) {
//         return (_auction.tokenId == tokenIdToAuction[]);
//     }
//     // function _isOnAuction(uint _id) internal view returns (bool) {
//     //     return (auction.tokenId == tokenIdToAuction[_id].tokenId);
//     // }

//     // function() payable  external { require(msg.data.length == 0); emit LogDepositReceived(msg.sender); }
//     /// @notice No tipping!
//     /// @dev Reject all Ether from being sent here, unless it's from one of the
//     ///  two auction contracts. (Hopefully, we can prevent user accidents.)
//     ///  but,contracts can not prevent other contracts from forcibly transfering ether to  contracts.
//     // function() external payable {
//     //     require(
//     //         msg.sender == address(saleAuction) ||
//     //         msg.sender == address(siringAuction)
//     //     );
//     // }

// }