pragma solidity ^0.4.18;

import "../helper/ERC721.sol";
import "../helper/Ownable.sol";
import "../helper/util/SafeMath.sol";

contract Collectable is ERC721 {


  using SafeMath for uint256;
  using SafeMath for uint32;
  using SafeMath16 for uint16;
  using AddressUtils for address;

  // Total amount of tokens
  uint256 private totalTokens;

  // Mapping from token ID to owner
  mapping (uint256 => address) internal tokenOwner;

  // Mapping from owner to list of owned token IDs
  // //todo change to map of map
  //mapping (address => uint256[]) private ownedTokens;
  mapping (address =>mapping(uint256 => bool)) private ownedTokens;

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

/**
* @dev Mint token function
* @param _to The address that will own the minted token
* @param _tokenId uint256 ID of the token to be minted by the msg.sender
*/
function _mint(address _to, uint256 _tokenId) internal {
  require(_to != address(0));
  addToken(_to, _tokenId);
  emit Transfer(0x0, _to, _tokenId);
}

/**
* @notice Mapping in mapping is not tested
* @dev Internal function to remove a token ID from the list of a given address
* @param _from address representing the previous owner of the given token ID
* @param _tokenId uint256 ID of the token to be removed from the tokens list of the given address
*/
function removeToken(address _from, uint256 _tokenId) private {
  require(ownerOf(_tokenId) == _from);

  uint256 lastTokenIndex = balanceOf(_from).sub(1);
  uint256 lastToken = ownedTokens[_from][lastTokenIndex];

  tokenOwner[_tokenId] = 0;
  delete ownedTokens[_from][_tokenId]
  totalTokens = totalTokens.sub(1);
}


/**
 * @dev Internal function to add a token ID to the list of a given address
 * @param _to address representing the new owner of the given token ID
 * @param _tokenId uint256 ID of the token to be added to the tokens list of the given address
 */
 function addToken(address _to, uint256 _tokenId) private {
   require(tokenOwner[_tokenId] == address(0));
   tokenOwner[_tokenId] = _to;
   //ownedTokens[_to].push(_tokenId);
   ownedTokens[_to][_tokenId] = true;
   totalTokens = totalTokens.add(1);
 }


}
