pragma solidity ^0.4.18;

import "../helper/Pausable.sol";

contract SanctuaryInterface {
    /// @dev simply a boolean to indicate this is the contract we expect to be
    function isSanctuary() public pure returns (bool);

    /// @dev generate new collectables
    /// @param _level Level of the collectable
    /// @return the genes that are supposed to be passed down to newly arisen collectable
    function generateCollectable(uint256 _genes , uint256 _level ) public returns (uint256);
}


/* collectable identity generator*/
contract CollectableGenerator is Pausable, SanctuaryInterface {

    //todo core contract is not implemented
    CryptoCollectableCore public coreContract;

    // / @dev simply a boolean to indicate this is the contract we expect to be
    function isSanctuary() public pure returns (bool){
        return true;
    }

    // / @dev generate new collectable identity
    // / @param _genes Genes of collectable that invoked resurrection, if 0 => Demigod gene that signals to generate unique collectable
    // / @param _level Level of the collectable
    // / @return the identity that are supposed to be passed down to newly arisen collectable
    function generateCollectable(uint256 _genes, uint256 _Level)
    public returns (uint256)
    {
        //only core contract can call this method
        require(msg.sender == address(coreContract));

        return _generateIdentity(_genes, _level);
    }

    function _generateIdentity(uint256 _genes, uint256 _Level) internal returns(uint256){
        return identity;
    }
}
