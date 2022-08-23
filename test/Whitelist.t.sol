// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.16;

import "forge-std/Test.sol";
import "src/Whitelist.sol";

interface CheatCodes {
   // Gets address for a given private key, (privateKey) => (address)
   function addr(uint256) external returns (address);
}

contract WhitelistTest is Test {
    Whitelist whitelist;
    address deployer;
    address user1 = address(1);
    address user2 = address(2);
    CheatCodes cheats = CheatCodes(HEVM_ADDRESS);

    // optional function invoked before each test case is run
    function setUp() public {
        whitelist = new Whitelist(10);
        deployer = address(this);
    }

    function testGetNumAddressesWhitelisted() public {
        uint8 numOfAddressesWhitelisted = whitelist.getNumAddressesWhitelisted();
        assertEq(numOfAddressesWhitelisted, 0);
        emit log_named_uint("There are this number of whitelisted addresses", numOfAddressesWhitelisted);
    }

    function testOneUserGetsWhitelisted() public {
        emit log_named_address("Address from msg.sender", address(msg.sender));
        assertEq(whitelist.isAddressWhitelisted(address(msg.sender)), false);
        // call function with address from msg.sender
        vm.prank(address(msg.sender));
        whitelist.addAddressToWhitelist();
        assertEq(whitelist.isAddressWhitelisted(address(msg.sender)), true);
        uint8 numOfAddressesWhitelisted = whitelist.getNumAddressesWhitelisted();
        assertEq(numOfAddressesWhitelisted, 1);
    }

    // each user can only be added once to the whitelist, this test checks this property
    function testFailSameUserTwice() public {
        assertEq(whitelist.isAddressWhitelisted(address(msg.sender)), false);
        // call function with address from msg.sender
        vm.prank(address(msg.sender));
        whitelist.addAddressToWhitelist();
        assertEq(whitelist.isAddressWhitelisted(address(msg.sender)), true);
        
        // this will revert, msg.sender already added
        vm.prank(address(msg.sender));
        whitelist.addAddressToWhitelist();
    }

    // only 10 addresses are allowed to enroll to the whitelist
    // this function tests if the function fails when the 11th user appears
    function testFailTooMany() public {
        for (uint8 index = 1; index < 12; index++) {
            address user = cheats.addr(index);
            vm.prank(user);
            // will fail with user 11
            whitelist.addAddressToWhitelist();
            uint8 numOfAddressesWhitelisted = whitelist.getNumAddressesWhitelisted();
            emit log_named_uint("There are this number of whitelisted addresses", numOfAddressesWhitelisted);
        }
    }
}