// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    constructor() ERC20("MyToken", "MTK") {
        _mint(msg.sender, 1000000 * (10 ** uint256(decimals())));
    }
}

contract MinimalProxy {
    // Storage slot in the proxy contract
    bytes32 private constant _implementationSlot = keccak256("eip1167.proxy.implementation");

    constructor(address initialImplementation) {
        // Initialize storage slot with implementation address
        assembly {
            sstore(_implementationSlot, initialImplementation)
        }
    }

    fallback() external payable {
        // Delegate call to the implementation contract
        assembly {
            let implementation := sload(_implementationSlot)
            calldatacopy(0, 0, calldatasize())
            let result := delegatecall(gas(), implementation, 0, calldatasize(), 0, 0)
            returndatacopy(0, 0, returndatasize())
            switch result
            case 0 { revert(0, returndatasize()) }
            default { return(0, returndatasize()) }
        }
    }

    function implementation() public view returns (address) {
        assembly {
            return sload(_implementationSlot)
        }
    }
}
