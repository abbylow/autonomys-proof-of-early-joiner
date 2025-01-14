import Image from "next/image"
import { Badge } from "@/components/ui/badge"
import { Card } from "@/components/ui/card"
import { SiteHeader } from "@/components/site-header"
import MintBtn from "@/components/mint-btn"

export default function Page() {
  return (
    <div className="min-h-screen flex flex-col">
      <SiteHeader />
      <main className="flex-1 container py-16 max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="grid gap-16 lg:grid-cols-2 lg:gap-12 items-start max-w-6xl mx-auto">
          <Card className="aspect-square relative overflow-hidden">
            <Image
              src="/nft.png?height=600&width=600"
              alt="Autonomys Genesis NFT Preview"
              className="object-cover"
              fill
              priority
            />
          </Card>
          <div className="flex flex-col gap-6">
            <div className="space-y-2">
              <div className="flex items-center gap-2">
                <h1 className="text-3xl font-bold">Autonomys Genesis NFT</h1>
                <Badge variant="secondary">Free Mint</Badge>
              </div>
              <p className="text-muted-foreground">Limited time exclusive NFT for early supporters</p>
            </div>
            
            <div className="space-y-4">
              <div className="prose prose-sm dark:prose-invert">
                <h3>About this NFT</h3>
                <p>
                  Be part of the Autonomys Network from the beginning. This exclusive Genesis NFT 
                  represents your early support and grants you special access to future network features.
                </p>
                <ul>
                  <li>Proof of early network participation</li>
                  <li>One NFT per wallet address</li>
                  <li>Available until January 31st, 2025</li>
                  <li>Zero minting cost (gas fees apply)</li>
                </ul>
              </div>

              <div className="space-y-2">
                <p className="text-sm text-muted-foreground">
                  Minting ends on January 31st, 2025
                </p>
                <MintBtn />
              </div>
            </div>
          </div>
        </div>
      </main>
    </div>
  )
}

