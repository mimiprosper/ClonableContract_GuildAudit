// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import './ClonableToken.sol';


contract MinProxy {
    address[] public storeproxies;

    event CreatClone(address clone);

    function createClone(
        address implementation,
        string memory name,
        string memory symbol,
        uint8 decimals,
        uint256 initialSupply,
        address owner
    ) external returns (address) {
        address clone = Clones.clone(implementation);

        ERC20Token(clone).initialize(name, symbol, decimals, initialSupply, owner);
        storeproxies.push(clone);
        emit CreatClone(clone);
        return clone;
    }
}