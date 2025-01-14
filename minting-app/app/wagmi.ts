import { getDefaultConfig } from '@rainbow-me/rainbowkit';

import { autoTaurus } from '@/const/taurusChain';

export const config = getDefaultConfig({
  appName: 'Autonomys Genesis NFT',
  projectId: process.env.NEXT_PUBLIC_WALLET_CONNECT_PROJECT_ID || "",
  chains: [
    autoTaurus
  ],
  ssr: true,
});
