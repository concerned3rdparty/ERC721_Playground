pragma solidity ^0.4.18;

import "../helper/ERC721.sol";
import "../helper/Ownable.sol";
import "../helper/util/SafeMath.sol";

contract Collectable is ERC721 {


  using SafeMath for uint256;

  mapping (uint => address) collectableApprovals;

  function balanceOf(address _owner) public view returns (uint256 _balance) {
    //return ownerCollectableCount state
  }

  function ownerOf(uint256 _tokenId) public view returns (address _owner) {
    //return owner of the collectable
  }

  function _transfer(address _from, address _to, uint256 _tokenId) private {
    //update relevant state counters
    Transfer(_from, _to, _tokenId);
  }

  function transfer(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
    _transfer(msg.sender, _to, _tokenId);
  }

  function approve(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
    collectableApprovals[_tokenId] = _to;
    Approval(msg.sender, _to, _tokenId);
  }

  function takeOwnership(uint256 _tokenId) public {
    require(collectableApprovals[_tokenId] == msg.sender);
    address owner = ownerOf(_tokenId);
    _transfer(owner, msg.sender, _tokenId);
  }

}
