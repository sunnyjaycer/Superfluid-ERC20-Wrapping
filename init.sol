// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
pragma abicoder v2;

import {
    ISuperfluid,
    ISuperToken,
    ISuperTokenFactory
} from "@superfluid-finance/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol";
import { ERC20WithTokenInfo } from "@superfluid-finance/ethereum-contracts/contracts/interfaces/tokens/ERC20WithTokenInfo.sol";

contract initMakerSuperToken {
    
    event NewSuperToken(address _contractAddress);
    mapping (address => address) superTokenRegistry;
    
    ISuperfluid private _host; // Goerli host: 0x22ff293e14F1EC3A09B137e9e06084AFd63adDF9
                               //  Mumbai host: 0xEB796bdb90fFA0f28255275e16936D25d3418603
    
    constructor(address _sfHost) {
        
        _host = ISuperfluid(_sfHost); // Superfluid host address
        
    }
    
    function createMakerSuperToken(ERC20WithTokenInfo mkrToken) public returns (ISuperToken mkrSuperToken) {
        
        // Goerli testMaker address: 0xdfec82f5e4aadfc0f68c9d38ab520df08affadc1
        // Mumbai testMaker address: 0x445F5cA0325150635F73B7E82DD1373aC0bE2a9d
        // name: Super Fake Maker
        // symbol: MKRtx
        
        string memory name = string(abi.encodePacked('Super ', mkrToken.name()));
        string memory symbol = string(abi.encodePacked(mkrToken.symbol(), 'x'));
        
        ISuperTokenFactory factory = _host.getSuperTokenFactory();
        mkrSuperToken = factory.createERC20Wrapper(mkrToken,ISuperTokenFactory.Upgradability.FULL_UPGRADABE,name,symbol);
    
        superTokenRegistry[address(mkrToken)] = address(mkrSuperToken);
        emit NewSuperToken(address(mkrSuperToken));
        
    }
    
    function getSuperToken(ERC20WithTokenInfo unwrappedToken) public view returns (address superTokenAddress) {
        
        superTokenAddress = superTokenRegistry[address(unwrappedToken)];
        
    }
    
}
