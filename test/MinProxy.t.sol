// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {ERC20Token} from "../src/ClonableToken.sol";
import {MinimalProxyFactory } from "../src/MinProxy.sol";

contract MinProxyTest is Test {
    ERC20Token public token;
    MinimalProxyFactory public proxyFactory;

    address user1 = makeAddr("user1");
    address user2 = makeAddr("user2");


    function setUp() public {
    // constructor not used in the contract so the argument would not be in the test
       token = new ERC20Token();
       proxyFactory = new MinimalProxyFactory();
    }

    function testTransfer() public {
       vm.startPrank(user1);
       address proxy = proxyFactory.deployClone(address(token));
       ERC20Token proxyToken = ERC20Token(address(proxy));
       proxyToken.initialize("TestToken", "TST", 18, 1000, user1);
       proxyToken.transfer(user2, 1000);
    }

}
