import type { AppProps } from 'next/app'
import { ChakraProvider } from '@chakra-ui/react'
import { extendTheme } from '@chakra-ui/react'
import { Web3Provider, useWeb3 } from '@crypto-cocoa/web3-provider'
import { CHAIN_ID } from 'src/constants/chainIds'
import ERC721 from '@sample-package/contract/artifacts/contracts/CocoaNFT.sol/CocoaNFT.json'

const ethereumMainnet = 1
const theme = extendTheme({
  initialColorMode: 'dark',
  useSystemColorMode: false
})

const contractOptions = [
  {
    address: process.env.NEXT_PUBLIC_NFT_CONTRACT_ADDRESS || '',
    abi: ERC721.abi,
    name: 'nftContract'
  }
]

function CocoaClub({ Component, pageProps }: AppProps) {
  console.log(ERC721.abi)

  return (
    <ChakraProvider theme={theme}>
      <Web3Provider chainId={ethereumMainnet} contractOptions={contractOptions}>
        <Component {...pageProps} />
      </Web3Provider>
    </ChakraProvider>
  )
}

export default CocoaClub
