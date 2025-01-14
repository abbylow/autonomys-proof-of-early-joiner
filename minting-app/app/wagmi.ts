import { getDefaultConfig } from '@rainbow-me/rainbowkit';
import { defineChain } from 'viem';

const autoTaurus = defineChain({
  id: 490000,
  name: 'Autonomys Taurus EVM',
  nativeCurrency: { name: 'Testnet AI3', symbol: 'tAI3', decimals: 18 },
  rpcUrls: {
    default: {
      http: ['https://auto-evm-0.taurus.subspace.network/ws'],
    },
  },
  blockExplorers: {
    default: {
      name: 'Blockscout',
      url: 'https://blockscout.taurus.autonomys.xyz/',
      apiUrl: 'https://blockscout.taurus.autonomys.xyz/api/',
    },
  },
  testnet: true
})

export const config = getDefaultConfig({
  appName: 'Autonomys Genesis NFT',
  projectId: process.env.NEXT_PUBLIC_WALLET_CONNECT_PROJECT_ID || "",
  chains: [
    autoTaurus
  ],
  ssr: true,
});
