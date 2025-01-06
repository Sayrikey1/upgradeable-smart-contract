// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

// storage is stored in the proxy contract, NOT in the implementation contract

// proxy -> deploy implementation contract -> call some "initializer" function -> set implementation contract address in proxy contract -> call implementation contract functions

contract BoxV1 is Initializable, UUPSUpgradeable, OwnableUpgradeable{
    uint256 internal number;

    // We can't use constructors with our proxies, 
    // because constructors add storage to the contract,
    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }    

    function initialize() public initializer {
        __Ownable_init(msg.sender); // sets owner to msg.sender
        __UUPSUpgradeable_init(); // best practice to call this after Ownable
    }

    function getValue() external view returns (uint256) {
        return number;
    }

    function version() external pure returns (uint256) {
        return 1;
    }

    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}
}
