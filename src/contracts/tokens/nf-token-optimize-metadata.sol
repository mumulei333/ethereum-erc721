// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

import "./nf-token.sol";
import "./erc721-metadata.sol";
import "../utils/Strings.sol";

/**
 * @dev Optional metadata implementation for ERC-721 non-fungible token standard.
 */
contract NFTokenOptimizeMetadata is
  NFToken,
  ERC721Metadata
{
    using Strings for uint256;
    
    /**
    * @dev A descriptive name for a collection of NFTs.
    */
    string internal nftName;
    
    /**
    * @dev An abbreviated name for NFTokens.
    */
    string internal nftSymbol;
    
    /**
    * @dev external Metadata baseURI. 
    */
    string internal baseURI;


    /**
    * @dev Contract constructor.
    * @notice When implementing this contract don't forget to set nftName and nftSymbol.
    */
    constructor() {
        supportedInterfaces[0x5b5e139f] = true; // ERC721Metadata
    }

    /**
    * @dev Returns a descriptive name for a collection of NFTokens.
    * @return _name Representing name.
    */
    function name() external override view returns (string memory _name) {
        _name = nftName;
    }

    /**
    * @dev Returns an abbreviated name for NFTokens.
    * @return _symbol Representing symbol.
    */
    function symbol() external override view returns (string memory _symbol) {
        _symbol = nftSymbol;
    }
  
    function getBaseURI() external view returns (string memory) {
        return baseURI;
    }
    
    function _changeBaseURI(string memory newBaseURI) internal virtual {
        baseURI = string(abi.encodePacked(newBaseURI, nftSymbol, "/"));
    }
    
    
    /**
    * @dev A distinct URI (RFC 3986) for a given NFT.
    * @param _tokenId Id for which we want uri.
    * @return URI of _tokenId.
    */
    function tokenURI(uint256 _tokenId) external override view returns (string memory) {
        return string(abi.encodePacked(baseURI, _tokenId.toString()));
    }
 

}
