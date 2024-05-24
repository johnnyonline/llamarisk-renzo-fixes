// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

interface IEZETH {
    function totalSupply() external view returns (uint256);
    function mint(address _user, uint256 _amount) external;
}