// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

interface IXERC20 {
    function mint(address _user, uint256 _amount) external;
    function setLimits(address _bridge, uint256 _mintingLimit, uint256 _burningLimit) external;
}