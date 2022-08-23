// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.16;

import "forge-std/Script.sol";
import { Whitelist } from "../src/Whitelist.sol";

contract WhitelistScript is Script {
    function setUp() public {}

    function run() public {
        // vm.broadcast will sign the next transaction with the account provided 
        vm.broadcast();
        new Whitelist(10);
    }
}
