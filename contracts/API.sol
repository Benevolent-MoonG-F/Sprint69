//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";
import "@chainlink/contracts/src/v0.8/ConfirmedOwner.sol";

contract SprintApi is ChainlinkClient, ConfirmedOwner {
    using Chainlink for Chainlink.Request;

    bytes32 private jobId;
    uint256 private fee;

    // multiple params returned in a single oracle response
    uint256 public USDC;
    uint256 public BNB;
    uint256 public XRP;
    uint256 public SOL;
    uint256 public ADA;
    uint256 public AVAX;
    uint256 public DODGE;
    uint256 public DOT;

    event RequestMultipleFulfilled(
        bytes32 indexed requestId,
        uint256 USDC,
        uint256 BNB,
        uint256 XRP,
        uint256 SOL,
        uint256 ADA,
        uint256 AVAX,
        uint256 DODGE,
        uint256 DOT
    );

    constructor(
        address _linkToken,
        address _oracle,
        bytes32 _jobId
    ) ConfirmedOwner(msg.sender) {
        setChainlinkToken(_linkToken);
        setChainlinkOracle(_oracle);
        jobId = _jobId;
        fee = (1 * LINK_DIVISIBILITY) / 10; // 0,1 * 10**18 (Varies by network and job)
    }

    /**
     * @notice Request mutiple parameters from the oracle in a single transaction
     */
    function requestMultipleParameters() external {
        Chainlink.Request memory req = buildChainlinkRequest(
            jobId,
            address(this),
            this.fulfillMultipleParameters.selector
        );
        req.add(
            "urlBTC",
            "https://min-api.cryptocompare.com/data/price?fsym=USDC&tsyms=USD"
        );
        req.add("pathUSDC", "USDC");
        req.add(
            "urlBTC",
            "https://min-api.cryptocompare.com/data/price?fsym=BNB&tsyms=USD"
        );
        req.add("pathBNB", "BNB");
        req.add(
            "urlBTC",
            "https://min-api.cryptocompare.com/data/price?fsym=XRP&tsyms=USD"
        );
        req.add("pathXRP", "XRP");
        req.add(
            "urlBTC",
            "https://min-api.cryptocompare.com/data/price?fsym=SOL&tsyms=USD"
        );
        req.add("pathSOL", "SOL");
        req.add(
            "urlBTC",
            "https://min-api.cryptocompare.com/data/price?fsym=ADA&tsyms=USD"
        );
        req.add("pathBTC", "ADA");
        req.add(
            "urlUSD",
            "https://min-api.cryptocompare.com/data/price?fsym=AVAX&tsyms=USD"
        );
        req.add("pathAVAX", "AVAX");
        req.add(
            "urlEUR",
            "https://min-api.cryptocompare.com/data/price?fsym=DOGE&tsyms=USD"
        );
        req.add("pathDODGE", "DODGE");
        req.add(
            "urlBTC",
            "https://min-api.cryptocompare.com/data/price?fsym=DOT&tsyms=DOT"
        );
        req.add("pathDOT", "DOT");
        sendChainlinkRequest(req, fee); // MWR API.
    }

    function fulfillMultipleParameters(
        bytes32 requestId,
        uint256 USDCResponse,
        uint256 BNBResponse,
        uint256 XRPResponse,
        uint256 SOLResponse,
        uint256 ADAResponse,
        uint256 AVAXResponse,
        uint256 DODGEResponse,
        uint256 DOTResponse
    ) public recordChainlinkFulfillment(requestId) {
        emit RequestMultipleFulfilled(
            requestId,
            USDCResponse,
            BNBResponse,
            XRPResponse,
            SOLResponse,
            ADAResponse,
            AVAXResponse,
            DODGEResponse,
            DOTResponse
        );
        USDC = USDCResponse * 53283230290;
        BNB = BNBResponse * 163276975;
        XRP = XRPResponse * 48343101197;
        SOL = SOLResponse * 339268332;
        ADA = ADAResponse * 33820262544;
        AVAX = AVAXResponse * 270791556;
        DODGE = DODGEResponse * 132670764300;
        DOT = DOTResponse * 987579315;
    }

    /**
     * Allow withdraw of Link tokens from the contract
     */
    function withdrawLink() public onlyOwner {
        LinkTokenInterface link = LinkTokenInterface(chainlinkTokenAddress());
        require(
            link.transfer(msg.sender, link.balanceOf(address(this))),
            "Unable to transfer"
        );
    }
}
