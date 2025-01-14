import { ConnectButton } from '@rainbow-me/rainbowkit';

export function SiteHeader() {
  return (
    <header className="sticky top-0 z-50 w-full border-b bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60">
      <div className="container flex h-14 max-w-7xl mx-auto items-center justify-between px-4 sm:px-6 lg:px-8">
        <div className="flex items-center gap-2 font-bold">
          <span className="text-xl">Autonomys Genesis</span>
        </div>
        <ConnectButton />
      </div>
    </header>
  )
}

