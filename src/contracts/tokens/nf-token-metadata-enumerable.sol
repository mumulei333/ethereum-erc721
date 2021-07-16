// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

import "https://github.com/mumulei333/ethereum-erc721/src/contracts/tokens/nf-token.sol";
import "https://github.com/mumulei333/ethereum-erc721/src/contracts/tokens/erc721-metadata.sol";
import "https://github.com/mumulei333/ethereum-erc721/src/contracts/tokens/erc721-enumerable.sol";
import "https://github.com/mumulei333/ethereum-erc721/src/contracts/utils/Strings.sol";

/**
 * @dev Optional metadata enumerable implementation for ERC-721 non-fungible token standard.
 */
contract NFTokenMetadataEnumerable is
  NFToken,
  ERC721Metadata,
  ERC721Enumerable
{
    using Strings for uint256;
    
    /**
    * @dev List of revert message codes. Implementing dApp should handle showing the correct message.
    * Based on 0xcert framework error codes.
    */
    string constant INVALID_INDEX = "005007";
    
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
    * @dev Array of all NFT IDs.
    */
    uint256[] internal tokens;

    /**
    * @dev Mapping from token ID to its index in global tokens array.
    */
    mapping(uint256 => uint256) internal idToIndex;
    
    /**
    * @dev Mapping from owner to list of owned NFT IDs.
    */
    mapping(address => uint256[]) internal ownerToIds;

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
    
    function _mint(address _to, uint256 _tokenId) internal override virtual {
        super._mint(_to, _tokenId);
        tokens.push(_tokenId);
        idToIndex[_tokenId] = tokens.length - 1;
    }
    
    /**
    * @dev Returns the count of all existing NFTokens.
    * @return Total supply of NFTs.
    */
    function totalSupply() external override view returns (uint256) {
        return tokens.length;
    }

    /**
    * @dev Returns NFT ID by its index.
    * @param _index A counter less than `totalSupply()`.
    * @return Token id.
    */
    function tokenByIndex(uint256 _index) external override view returns (uint256) {
        require(_index < tokens.length, INVALID_INDEX);
        return tokens[_index];
    }

    /**
    * @dev returns the n-th NFT ID from a list of owner's tokens.
    * @param _owner Token owner's address.
    * @param _index Index number representing n-th token in owner's list of tokens.
    * @return Token id.
    */
    function tokenOfOwnerByIndex( address _owner, uint256 _index) external override view returns (uint256) {
        require(_index < ownerToIds[_owner].length, INVALID_INDEX);
        return ownerToIds[_owner][_index];
    }
    
 

}
