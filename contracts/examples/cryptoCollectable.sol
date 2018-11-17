pragma solidity ^0.4.18;

import "../helper/ERC721.sol";
import "../helper/Ownable.sol";
import "../helper/util/SafeMath.sol";

contract Collectable is ERC721 {


  using SafeMath for uint256;
  using SafeMath for uint32;
  using SafeMath16 for uint16;
  using AddressUtils for address;

  // Mapping from token ID to owner
  mapping (uint256 => address) internal tokenOwner;

  // Optional mapping for token URIs keeping data about token
  mapping(uint256 => string) internal tokenURIs;

  mapping (uint => address) collectableApprovals;

  function balanceOf(address _owner) public view returns (uint256 _balance) {
    //return ownerCollectableCount state
  }

  //return owner of the collectable
  function ownerOf(uint256 _tokenId) public view returns (address _owner) {
    address owner = tokenOwner[_tokenId];
    require(owner != address(0));
    return owner;
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

  /**
 * @dev Returns whether the specified token exists
 * @param _tokenId uint256 ID of the token to query the existence of
 * @return whether the token exists
 */
function exists(uint256 _tokenId) public view returns (bool) {
  address owner = tokenOwner[_tokenId];
  return owner != address(0);
}

function tokenURI(uint257 _tokenId) public view returns (string){
  require(exists(_tokenId));
  return tokenURIs[_tokenId];
}

}
