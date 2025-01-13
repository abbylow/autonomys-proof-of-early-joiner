// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/GenesisNFT.sol";

contract GenesisNFTTest is Test {
    GenesisNFT genesisNFT;

    address deployer = address(0x123);
    address otherAccount = address(0x456);

    string constant name = "Autonomys Genesis";
    string constant symbol = "AG";
    uint128 constant royaltyBps = 0;
    string constant baseURI =
        "ipfs://QmYpxHo5noc5TsqrAB5uybSaGEPD3mBkWxGCe7jpXqcsTy/";
    uint256 constant maxClaimableSupply = 10;
    uint256 constant quantityLimitPerWallet = 1;

    function setUp() public {
        // Deploy the GenesisNFT contract
        genesisNFT = new GenesisNFT(
            deployer, // defaultAdmin
            name,
            symbol,
            deployer, // royaltyRecipient
            royaltyBps,
            deployer // primarySaleRecipient
        );
    }

    function testDeployment() public view {
        // Verify deployment details
        assertEq(genesisNFT.name(), name, "Incorrect name");
        assertEq(genesisNFT.symbol(), symbol, "Incorrect symbol");
        assertEq(genesisNFT.owner(), deployer, "Incorrect owner");
    }

    function testLazyMint() public {
        // Lazy mint 10 tokens
        vm.prank(deployer);
        genesisNFT.lazyMint(10, baseURI, "");

        // Verify lazy mint
        uint256 nextTokenIdToMint = genesisNFT.nextTokenIdToMint();
        assertEq(nextTokenIdToMint, 10, "Incorrect nextTokenIdToMint");

        // Verify token metadata
        for (uint256 i = 0; i < 10; i++) {
            assertEq(
                genesisNFT.tokenURI(i),
                string.concat(baseURI, Strings.toString(i)),
                "Incorrect token URI"
            );
        }
    }

    function testSetClaimConditions() public {
        // Define the claim condition
        IClaimCondition.ClaimCondition memory claimCondition = IClaimCondition
            .ClaimCondition({
                startTimestamp: block.timestamp,
                maxClaimableSupply: maxClaimableSupply,
                supplyClaimed: 0,
                quantityLimitPerWallet: quantityLimitPerWallet,
                merkleRoot: bytes32(0),
                pricePerToken: 0,
                currency: address(0),
                metadata: ""
            });

        // Set claim conditions
        vm.prank(deployer);
        genesisNFT.setClaimConditions(claimCondition, false); // False = reset claim count

        // Retrieve the tuple from `claimCondition` - current claim condition
        (
            uint256 ccStartTimestamp,
            uint256 ccMaxClaimableSupply,
            uint256 ccSupplyClaimed,
            uint256 ccQuantityLimitPerWallet,
            bytes32 ccMerkleRoot,
            uint256 ccPricePerToken,
            address ccCurrency,
            string memory metadata
        ) = genesisNFT.claimCondition();

        // Verify individual fields
        assertEq(ccStartTimestamp, block.timestamp, "Incorrect startTimestamp");
        assertEq(ccMaxClaimableSupply, maxClaimableSupply, "Incorrect maxClaimableSupply");
        assertEq(ccSupplyClaimed, 0, "Incorrect supplyClaimed");
        assertEq(ccQuantityLimitPerWallet, quantityLimitPerWallet, "Incorrect quantityLimitPerWallet");
        assertEq(ccPricePerToken, 0, "Incorrect pricePerToken");
        assertEq(ccCurrency, address(0), "Incorrect currency");
    }

    function testClaimSuccessfully() public {
        // Lazy mint first
        vm.prank(deployer);
        genesisNFT.lazyMint(10, baseURI, "");

        // Define the claim condition
        IClaimCondition.ClaimCondition memory claimCondition = IClaimCondition
            .ClaimCondition({
                startTimestamp: block.timestamp,
                maxClaimableSupply: maxClaimableSupply,
                supplyClaimed: 0,
                quantityLimitPerWallet: quantityLimitPerWallet,
                merkleRoot: bytes32(0),
                pricePerToken: 0,
                currency: address(0),
                metadata: ""
            });

        // Set claim conditions
        vm.prank(deployer);
        genesisNFT.setClaimConditions(claimCondition, false); // False = reset claim count

        // Mint tokens using the `claim` function
        address receiver = otherAccount;
        uint256 quantity = 1;
        address currency = address(0); // Free mint
        uint256 pricePerToken = 0;
        IDropSinglePhase.AllowlistProof memory allowlistProof = IDropSinglePhase.AllowlistProof({
            proof: new bytes32[](0), // No proof since no allowlist
            quantityLimitPerWallet: 0, // Not applicable here
            pricePerToken: 0, // Free mint
            currency: address(0) // Native currency
        });

        // Verify balance before claim
        assertEq(genesisNFT.balanceOf(receiver), 0, "Before claim balance is not 0");

        // Claim tokens
        vm.prank(receiver);
        genesisNFT.claim(receiver, quantity, currency, pricePerToken, allowlistProof, "");

        // Verify mint
        assertEq(genesisNFT.balanceOf(receiver), 1, "Mint failed or incorrect balance");

        (
            uint256 ccStartTimestamp,
            uint256 ccMaxClaimableSupply,
            uint256 ccSupplyClaimed,
            uint256 ccQuantityLimitPerWallet,
            bytes32 ccMerkleRoot,
            uint256 ccPricePerToken,
            address ccCurrency,
            string memory metadata
        ) = genesisNFT.claimCondition();
        
        assertEq(ccSupplyClaimed, 1, "Incorrect supply claimed");
    }

    
    function testClaimFailed() public {
        // Lazy mint first
        vm.prank(deployer);
        genesisNFT.lazyMint(10, baseURI, "");

        // Define the claim condition
        IClaimCondition.ClaimCondition memory claimCondition = IClaimCondition
            .ClaimCondition({
                startTimestamp: block.timestamp,
                maxClaimableSupply: maxClaimableSupply,
                supplyClaimed: 0,
                quantityLimitPerWallet: quantityLimitPerWallet,
                merkleRoot: bytes32(0),
                pricePerToken: 0,
                currency: address(0),
                metadata: ""
            });

        // Set claim conditions
        vm.prank(deployer);
        genesisNFT.setClaimConditions(claimCondition, false); // False = reset claim count

        // Mint tokens using the `claim` function
        address receiver = otherAccount;
        uint256 quantity = 2;
        address currency = address(0); // Free mint
        uint256 pricePerToken = 0;
        IDropSinglePhase.AllowlistProof memory allowlistProof = IDropSinglePhase.AllowlistProof({
            proof: new bytes32[](0), // No proof since no allowlist
            quantityLimitPerWallet: 0, // Not applicable here
            pricePerToken: 0, // Free mint
            currency: address(0) // Native currency
        });

        // Verify balance before claim
        assertEq(genesisNFT.balanceOf(receiver), 0, "Before claim balance is not 0");

        // Claim tokens
        vm.prank(receiver);

        // Verify DropClaimExceedLimit is thrown
        try genesisNFT.claim(receiver, quantity, currency, pricePerToken, allowlistProof, "") {
            fail();
        } catch (bytes memory reason) {
            // Decode the revert reason for custom error
            bytes4 expectedSelector = DropSinglePhase.DropClaimExceedLimit.selector;
            bytes4 actualSelector = bytes4(reason);
            assertEq(actualSelector, expectedSelector, "Incorrect error selector");
        }
    }
}
