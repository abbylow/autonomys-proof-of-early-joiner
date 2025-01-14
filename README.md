
# Autonomys Proof of Early Joiner - Genesis NFT Project

This project is an **imaginary Genesis NFT** initiative for the **Autonomys Network**. This exclusive Genesis NFT is a token of early support and participation in the Autonomys Network. Holders of this NFT will gain special access to future features of the network.



## Features
- **Exclusive Genesis NFT**:
  - Total Supply: **10** (for assignment purposes).
  - Represents proof of early participation in the network.
  - Grants special access to future Autonomys Network features.

- **Minting Details**:
  - **One NFT per wallet**: Ensures fairness and uniqueness.
  - **Zero minting cost**: Only gas fees apply.



## File Structure
This repository consists of two main projects:
1. **Minting App**: A Next.js frontend application for minting the Genesis NFT.
2. **NFT Contract**: A Foundry-based project containing the NFT's source code, tests, and deployment scripts.



### 1. Minting App
The **Minting App** is a Next.js application that allows users to mint their Genesis NFT from a user-friendly frontend interface.

#### **How to Run the Minting App**
1. Clone the repository.
2. Navigate to the `minting-app` directory.
3. Create a `.env` file by copying `.env.example`:
   ```bash
   cp .env.example .env
4. Add your WalletConnect Project ID to the .env file.
5. Install dependencies:
    ```
    npm install
    ```
6. Run the development server:
    ```
    npm run dev
    ```



### 2. NFT Contract
The NFT Contract project is built with Foundry and contains:
- Source Code: `nft/src` (e.g., the NFT contract logic).
- Test Cases: `nft/test` (tests for the contract functionality).
- Deployment Script: `nft/script` (a script to deploy the NFT).

#### **How to Run the NFT Contract Project**
1. Clone the repository.
2. Navigate to the nft directory.
3. Create a .env file by copying .env.example:
    ```
    cp .env.example .env
    ```
4. Add the following details to the .env file:
- RPC URL: The RPC URL of the blockchain to deploy on.
- Private Key: The private key of the wallet to deploy the contract.
5. Build the project:
    ```
    make build
    ```
6. Deploy the NFT contract:
    ```
    make deploy
    ```


## Deployed instances 🚀
Minting App: https://autonomys-proof-of-early-joiner.vercel.app/ 

NFT: https://blockscout.taurus.autonomys.xyz/address/0xd60fe4ee27B2809AcC3C8935bE7551642958b6a3?tab=txs 


## Acknowledgements
This project was built as part of an assignment to demonstrate the development and integration of a Genesis NFT project using Foundry and Next.js on Auto EVM (Taurus Testnet). 
