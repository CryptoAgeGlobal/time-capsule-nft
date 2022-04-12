// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

import '@openzeppelin/contracts/token/ERC721/ERC721.sol';
import '@openzeppelin/contracts/utils/Counters.sol';
import '@openzeppelin/contracts/access/Ownable.sol';

contract TimeCapsuleNFT is ERC721, Ownable {
    
    constructor() ERC721('TC', 'TimeCapsuleNFT') {}
    uint64 _tokenId;
    string secretUri;//掘り起こす前のURI(共通)

    struct Capsule {
       string tokenUri;//掘り起こした後のURI(個別)
       uint64 timeToDigUp;
       address creator;
       bool isDigUp;
    }

    mapping(uint64 => Capsule) _capsules;

    function mint(string memory _uri,uint64 _period) public {        
        _tokenId++;
        _mint(msg.sender, _tokenId);
        _capsules[_tokenId] = Capsule(_uri, xblock.timestamp + _period, msg.sender, false);
    }

    function digUp(uint64 _id)public {
        require(_capsules[_id].creator == msg.sender);
        require(_capsules[_id].isDigUp == false);
        _capsules[_id].isDigUp = true;
    }

    function tokenURI(uint256 tokenId) public override virtual returns(string memory) {
      // もしCapsuleのisDigUpがtrueがだったら、secretUriを返す
      if (_capsules[tokenId].isDigUp == true) {
          return abi.encodePacked(baseURI, tokenId, ".json");
      }

      // もしCapsuleのisDigUpがtrueがだったら、secretUriを返す
      else {
          return secretUri;
      }
      
    }
}
