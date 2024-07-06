// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract MinimalProxyFactory {

    address[] public proxies;

    function deployClone(address _implementationContract) external returns (address) {
        bytes20 implementationContractInBytes = bytes20(_implementationContract);
        address proxy;

        assembly {
            // Allocate memory for the bytecode
            let clone := mload(0x40)
            mstore(
                clone,
                0x3d602d80600a3d3981f3363d3d373d3d3d363d73000000000000000000000000
            )
            // Store the implementation contract address in the correct location
            mstore(add(clone, 0x14), implementationContractInBytes)
            mstore(
                add(clone, 0x28),
                0x5af43d82803e903d91602b57fd5bf30000000000000000000000000000000000
            )
            // Create the new proxy contract
            proxy := create(0, clone, 0x37)
        }

        // push to the array
        proxies.push(proxy);
        return proxy;
    }
} 
