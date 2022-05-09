// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface Token {
    /// @param _owner The address from which the balance will be retrieved
    /// @return balance the balance
    function balanceOf(address _owner) external view returns (uint256 balance);

    /// @notice send `_value` token to `_to` from `msg.sender`
    /// @param _to The address of the recipient
    /// @param _value The amount of token to be transferred
    /// @return success Whether the transfer was successful or not
    function transfer(address _to, uint256 _value)
        external
        returns (bool success);

    /// @notice send `_value` token to `_to` from `_from` on the condition it is approved by `_from`
    /// @param _from The address of the sender
    /// @param _to The address of the recipient
    /// @param _value The amount of token to be transferred
    /// @return success Whether the transfer was successful or not
    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) external returns (bool success);

    /// @notice `msg.sender` approves `_addr` to spend `_value` tokens
    /// @param _spender The address of the account able to transfer the tokens
    /// @param _value The amount of wei to be approved for transfer
    /// @return success Whether the approval was successful or not
    function approve(address _spender, uint256 _value)
        external
        returns (bool success);

    /// @param _owner The address of the account owning tokens
    /// @param _spender The address of the account able to transfer the tokens
    /// @return remaining Amount of remaining tokens allowed to spent
    function allowance(address _owner, address _spender)
        external
        view
        returns (uint256 remaining);

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );
}

pragma solidity ^0.8.13;

contract Sprint69 {
    Token public paymentToken;

    uint256 public round;
    // shows if an asset is in top 15 when the round begins
    mapping(uint256 => mapping(bytes8 => bool)) private s_assetIsTop15;
    //asset position on the sprint
    mapping(uint256 => mapping(bytes8 => uint8)) private s_assetPosition;

    mapping(uint256 => Round) public s_roundInfo;

    struct Round {
        uint256 startTime;
        uint256 endTime;
        uint256 pickEndTime;
        uint256 totalStaked;
        uint256 totalPlayers;
    }

    mapping(uint256 => mapping(address => uint8[5])) public s_addressPicks;

    constructor(address _paymentToken) {
        paymentToken = Token(_paymentToken);
        round = 1;
        Round storage firstRound = s_roundInfo[round];
        firstRound.startTime = block.timestamp;
        firstRound.endTime = (block.timestamp + 3 days);
        firstRound.pickEndTime = (block.timestamp + 36 hours);
    }

    function selectAssets(uint8[5] memory _assets) external {
        s_addressPicks[round][msg.sender] = _assets;
    }

    function getAssetPosition(bytes8 _asset) external view returns (uint8) {
        return s_assetPosition[round][_asset];
    }

    function getAssetStatus(bytes8 _asset) external view returns (bool status) {
        status = s_assetIsTop15[round][_asset];
    }
}
