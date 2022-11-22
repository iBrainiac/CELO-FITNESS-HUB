# Dacade Fitness Hub
 find link of the site here for demo
https://ibrainiac.github.io/DACADE-FITNESS-HUB/

## Description
This is a fitness hub dAPP where  users can:
- list fitness services they offer and price them in cUSD
- anyone can purchase a fitness service by connecting their wallets and purchase desired service using cUSD
- cUSD deducted from the person who purchases a fitness service and credited to the service provider's/ coach or trainer wallet.


The novelty here is fitness trainers offering a fitness service can list their services and price them in cUSD thus any interested trainee can purchase the services using their CELO wallets. Transaction ID of wallet address represent payment of the service and is the proof of payment as well as the receipt for access to the fitness service

## Smart Contract Functionality Added
- Add a fitness service to the dAPP assigning  fee in cUSD
- Transfer cUSD token from purchaser of sports service  wallet to  fitness coach/ sports service provider's wallet
- Update Sales Price Method


## Front End Functionality Added
- Update fitness service with the option to update price .


## TODO
- Update fitness service with the option to update price or cancel sale
- Add more characteristics such as number of hours for training
- Allow sports service provider mint cards representing service offered with added features like long term membership, access of more than one sports service and allow purchaser to sell the NFT to pass on ownership to a new owner   
- NFTs to represent the sports services membership fee thus various access rughts to whoever owns the NFT
- Cancel the sale of a service you own that haven't had any sales yet

### Test
1. Create a fitness service
2. Create a second account in your extension wallet and send them cUSD tokens.
3. Buy sports fitness service with secondary account.
4. Check if balance of first account increased.
5. Check your wallet to see if you have the transaction of sports service in your wallet
6. Create another sports service.




# PROJECT SETUP

# Install

```

npm install

```

or 

```

yarn install

```

# Start

```

npm run dev

```

# Build

```

npm run build

```
# Usage
1. Install the [CeloExtensionWallet](https://chrome.google.com/webstore/detail/celoextensionwallet/kkilomkmpmkbdnfelcpgckmpcaemjcdh?hl=en) from the google chrome store.
2. Create a wallet.
3. Go to [https://celo.org/developers/faucet](https://celo.org/developers/faucet) and get tokens for the alfajores testnet.
4. Switch to the alfajores testnet in the CeloExtensionWallet.
// cA 0xd9145CCE52D386f254917e481eB44e9943F39138

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
GAS_REPORT=true npx hardhat test
npx hardhat node
npx hardhat run scripts/deploy.js
```
