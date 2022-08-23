// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.16;

import "forge-std/Test.sol";
import "src/Whitelist.sol";

contract WhitelistTest is Test {
    Whitelist whitelist;
    // optional function invoked before each test case is run
    function setUp() public {
        whitelist = new Whitelist(10);
    }

    function testGetNumAddressesWhitelisted() public {
        uint8 numOfAddressesWhitelisted = whitelist.getNumAddressesWhitelisted();
        assertEq(numOfAddressesWhitelisted, 0);
        emit log_named_uint("There are this number of whitelisted addresses", numOfAddressesWhitelisted);
    }
}