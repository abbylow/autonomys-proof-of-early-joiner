export const ABI = [
    {
        "type": "function",
        "name": "getSupplyClaimedByWallet",
        "inputs": [
            {
                "name": "_claimer",
                "type": "address",
                "internalType": "address"
            }
        ],
        "outputs": [
            {
                "name": "",
                "type": "uint256",
                "internalType": "uint256"
            }
        ],
        "stateMutability": "view"
    },
    {
        "type": "function",
        "name": "claim",
        "inputs": [
            {
                "name": "_receiver",
                "type": "address",
                "internalType": "address"
            },
            {
                "name": "_quantity",
                "type": "uint256",
                "internalType": "uint256"
            },
            {
                "name": "_currency",
                "type": "address",
                "internalType": "address"
            },
            {
                "name": "_pricePerToken",
                "type": "uint256",
                "internalType": "uint256"
            },
            {
                "name": "_allowlistProof",
                "type": "tuple",
                "internalType": "struct IDropSinglePhase.AllowlistProof",
                "components": [
                    {
                        "name": "proof",
                        "type": "bytes32[]",
                        "internalType": "bytes32[]"
                    },
                    {
                        "name": "quantityLimitPerWallet",
                        "type": "uint256",
                        "internalType": "uint256"
                    },
                    {
                        "name": "pricePerToken",
                        "type": "uint256",
                        "internalType": "uint256"
                    },
                    {
                        "name": "currency",
                        "type": "address",
                        "internalType": "address"
                    }
                ]
            },
            {
                "name": "_data",
                "type": "bytes",
                "internalType": "bytes"
            }
        ],
        "outputs": [],
        "stateMutability": "payable"
    }
];
