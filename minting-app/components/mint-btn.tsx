'use client';

import { ethers } from 'ethers';
import { Loader2 } from "lucide-react"
import { type BaseError, useAccount, useReadContract, useWaitForTransactionReceipt, useWriteContract } from 'wagmi';

import { Button } from "@/components/ui/button"
import { NFT_CONTRACT_ADDRESS } from '@/const/contracts';
import { ABI } from '@/const/abi';

export default function MintBtn() {
    const { address } = useAccount()

    const { data: supplyClaimedByUser } = useReadContract({
        address: NFT_CONTRACT_ADDRESS,
        abi: ABI,
        functionName: 'getSupplyClaimedByWallet',
        args: [address],
    })

    const { data: hash, writeContract, isPending, error } = useWriteContract()

    const handleMint = async () => {
        try {
            writeContract({
                address: NFT_CONTRACT_ADDRESS,
                abi: ABI,
                functionName: 'claim',
                args: [
                    address, // Receiver address
                    BigInt(1), // Claim 1 NFT
                    ethers.ZeroAddress, // Native currency (ETH/MATIC)
                    BigInt(0), // Free mint (0 price per token)
                    {
                        proof: [], // Empty proof for open claims
                        quantityLimitPerWallet: BigInt(1), // Quantity limit per wallet
                        pricePerToken: BigInt(0), // Free mint
                        currency: ethers.ZeroAddress, // Native currency
                    },
                    "0x", // No additional data
                ],
            })
        } catch (err) {
            console.error("Fail to mint ", err)
        }

    }

    const { isLoading: isConfirming, isSuccess: isConfirmed } = useWaitForTransactionReceipt({ hash })


    if (supplyClaimedByUser) {
        return (
            <div className='flex flex-col gap-2'>
                <Button size="lg" className="w-full" disabled={true}>
                    Minted
                </Button>
            </div>
        )
    }

    return (
        <div className='flex flex-col gap-2'>
            <Button
                size="lg"
                className="w-full"
                onClick={handleMint}
                disabled={!address || isConfirmed || isPending || isConfirming}
            >
                {(isPending || isConfirming) && <Loader2 className="animate-spin" />}
                {isConfirmed ? "Minted" : ((isPending || isConfirming) ? "Minting" : "Mint NFT")}
            </Button>

            {hash && (
                <a
                    href={`https://blockscout.taurus.autonomys.xyz/tx/${hash}`}
                    target="_blank"
                    rel="noopener noreferrer"
                    className='underline decoration-2 underline-offset-2 text-muted-foreground'
                >
                    Check transaction here
                </a>
            )}

            {error && (
                <p className='text-destructive'>Error: {(error as BaseError).shortMessage || error.message}</p>
            )}
        </div>
    )
}

