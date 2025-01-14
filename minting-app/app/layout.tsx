import type { Metadata } from "next"
import { Inter } from 'next/font/google'
import { Providers } from "./providers"

import "./globals.css"

const inter = Inter({ subsets: ["latin"] })

export const metadata: Metadata = {
  title: "Autonomys Genesis NFT",
  description: "Mint your exclusive Autonomys Network Genesis NFT",
}

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode
}>) {
  return (
    <html lang="en">
      <body className={inter.className}>
        <Providers>{children}</Providers>
      </body>
    </html>
  )
}

