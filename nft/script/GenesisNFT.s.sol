// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/GenesisNFT.sol";

contract DeployGenesisNFT is Script {
    function run() external {
        // Parameters
        address deployer = msg.sender;
        string memory name = "Autonomys Genesis";
        string memory symbol = "AG";
        uint128 royaltyBps = 0; // No royalties
        address royaltyRecipient = deployer;
        address primarySaleRecipient = deployer;
        string memory baseURI = "ipfs://QmYpxHo5noc5TsqrAB5uybSaGEPD3mBkWxGCe7jpXqcsTy/";
        uint256 maxClaimableSupply = 10;
        uint256 quantityLimitPerWallet = 1;

        // Start broadcasting transactions
        vm.startBroadcast();

        // Deploy GenesisNFT
        GenesisNFT genesisNFT = new GenesisNFT(
            deployer,
            name,
            symbol,
            royaltyRecipient,
            royaltyBps,
            primarySaleRecipient
        );

        console.log("GenesisNFT deployed at:", address(genesisNFT));

        // Batch mint 10 tokens
        genesisNFT.lazyMint(10, baseURI, "");

        console.log("Batch minted 10 tokens with baseURI:", baseURI);

        // Set claim conditions
        IClaimCondition.ClaimCondition memory claimCondition = IClaimCondition.ClaimCondition({
            startTimestamp: block.timestamp,
            maxClaimableSupply: maxClaimableSupply,
            supplyClaimed: 0,
            quantityLimitPerWallet: quantityLimitPerWallet,
            merkleRoot: bytes32(0), // No allowlist
            pricePerToken: 0, // Free mint
            currency: address(0), // Native currency (ETH)
            metadata: ""
        });

        genesisNFT.setClaimConditions(claimCondition, false);

        console.log("Claim conditions set successfully");

        // Stop broadcasting
        vm.stopBroadcast();
    }
}
