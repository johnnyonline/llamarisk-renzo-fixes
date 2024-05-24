// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "forge-std/Test.sol";
import "forge-std/console.sol";

contract PoCsTest is Test {

    function setUp() public {}

    function testSanity() public {
        // tests

        uint256 _minTime = 259200; // 3 days
        console.log("minTime in days: ", _minTime / 86400);

        address timelock = 0x81F6e9914136Da1A1d3b1eFd14F7E0761c3d4cc7;
        // -- load owner

        bytes32 ownerRaw = vm.load(address(timelock), bytes32(0xb53127684a568b3173ae13b9f8a6016e243e63b6e8ee1178d6a717850b5d6103));
        address owner = address(uint160(uint256(ownerRaw)));
        console.logAddress(owner);
    }
}
