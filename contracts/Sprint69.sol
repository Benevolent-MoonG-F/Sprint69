// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import {IERC20} from "../interfaces/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

error Transfer__Failed();

contract Sprint69 is Ownable {
    IERC20 public paymentToken;

    uint256 public round;
    // shows if an asset is in top 15 when the round begins
    mapping(uint256 => mapping(bytes8 => bool)) private s_assetIsTop15;
    //asset position on the sprint
    mapping(uint256 => mapping(bytes8 => uint8)) private s_assetPosition;
    //rount info
    mapping(uint256 => Round) public s_roundInfo;

    //Current price of the round
    uint256 public currentPrice;

    // Total Staked
    uint256 public s_totalStaked;

    struct Round {
        uint256 startTime;
        uint256 endTime;
        uint256 pickEndTime;
        uint256 totalStaked;
        uint256 totalPlayers;
    }

    mapping(uint256 => mapping(address => uint8[5])) public s_addressPicks;

    constructor(address _paymentToken) {
        paymentToken = IERC20(_paymentToken);
        round = 1;
        Round storage firstRound = s_roundInfo[round];
        firstRound.startTime = block.timestamp;
        firstRound.endTime = (block.timestamp + 3 days);
        firstRound.pickEndTime = (block.timestamp + 36 hours);
    }

    function selectAssets(uint8[5] memory _assets) external {
        uint256 _currentPrice = currentPrice;
        Round storage roundInfor = s_roundInfo[round];
        bool success = paymentToken.transferFrom(
            msg.sender,
            address(this),
            _currentPrice
        );
        if (!success) {
            revert Transfer__Failed();
        }
        s_addressPicks[round][msg.sender] = _assets;
        roundInfor.totalPlayers += 1;
        roundInfor.totalStaked = _currentPrice;
    }

    function getAssetPosition(bytes8 _asset) external view returns (uint8) {
        return s_assetPosition[round][_asset];
    }

    function getAssetStatus(bytes8 _asset) external view returns (bool status) {
        status = s_assetIsTop15[round][_asset];
    }
}
