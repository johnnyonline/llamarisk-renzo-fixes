// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import {AccessControlUpgradeable} from "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";

import {IEZETH} from "./interfaces/IEZETH.sol";

import "forge-std/Test.sol";
import "forge-std/console.sol";

contract PoCsTest is Test {

    address payable user;

    function setUp() public {
        vm.selectFork(vm.createFork(vm.envString("ETHEREUM_RPC_URL")));

        user = payable(makeAddr("user"));
    }

    // function testRenzo() public {

    //     // -- load owner

    //     // bytes32 ownerRaw = vm.load(address(0xC8140dA31E6bCa19b287cC35531c2212763C2059), bytes32(0xb53127684a568b3173ae13b9f8a6016e243e63b6e8ee1178d6a717850b5d6103));
    //     // address owner = address(uint160(uint256(ownerRaw)));
    //     // console.logAddress(owner);

    //     // -- grant roles 

    //     // IAccessControlUpgradeable _rolemanager = IAccessControlUpgradeable(0x4994EFc62101A9e3F885d872514c2dC7b3235849);
    //     // bytes32 NATIVE_ETH_RESTAKE_ADMIN = keccak256("NATIVE_ETH_RESTAKE_ADMIN");
    //     // address _msig = 0xD1e6626310fD54Eceb5b9a51dA2eC329D6D4B68A;

    //     // assertTrue(!_rolemanager.hasRole(NATIVE_ETH_RESTAKE_ADMIN, _msig), "testRenzo: E0");
    //     // assertTrue(!_rolemanager.hasRole(NATIVE_ETH_RESTAKE_ADMIN, user), "testRenzo: E1");

    //     // vm.prank(_msig);
    //     // _rolemanager.grantRole(NATIVE_ETH_RESTAKE_ADMIN, user);

    //     // assertTrue(!_rolemanager.hasRole(NATIVE_ETH_RESTAKE_ADMIN, _msig), "testRenzo: E2");
    //     // assertTrue(_rolemanager.hasRole(NATIVE_ETH_RESTAKE_ADMIN, user), "testRenzo: E3");

    //     // // -- mint XERC20

    //     // IXERC20 _xerc20 = IXERC20(0x2416092f143378750bb29b79eD961ab195CcEea5);
    //     // address _msig = 0xD1e6626310fD54Eceb5b9a51dA2eC329D6D4B68A;

    //     // uint256 _totalSupplyBefore = IERC20(address(_xerc20)).totalSupply();

    //     // // set limits
    //     // vm.startPrank(_msig);
    //     // _xerc20.setLimits(_msig, type(uint256).max, type(uint256).max);
    //     // _xerc20.mint(user, 10000 ether);

    //     // uint256 _totalSupplyAfter = IERC20(address(_xerc20)).totalSupply();

    //     // assertTrue(_totalSupplyAfter > _totalSupplyBefore, "testRenzo: E0");
    // }

    function testUncheckedMint() public {

        // set variables
        uint256 _amount = 100000 ether;
        bytes32 _role = keccak256("RX_ETH_MINTER_BURNER");
        address _msig = 0xD1e6626310fD54Eceb5b9a51dA2eC329D6D4B68A;
        IEZETH _ezETH = IEZETH(0xbf5495Efe5DB9ce00f80364C8B423567e58d2110);
        AccessControlUpgradeable _roleManager = AccessControlUpgradeable(0x4994EFc62101A9e3F885d872514c2dC7b3235849);

        // make sure user cant mint before role is granted
        vm.expectRevert();
        vm.prank(user);
        _ezETH.mint(user, _amount);

        // grant minter-burner role
        vm.prank(_msig);
        _roleManager.grantRole(_role, user);

        // inflate ezETH supply
        uint256 _totalSupplyBefore = _ezETH.totalSupply();

        vm.prank(user);
        _ezETH.mint(user, _amount);

        uint256 _totalSupplyAfter = _ezETH.totalSupply();

        assertTrue(_totalSupplyAfter > _totalSupplyBefore, "!supply");
    }
}
