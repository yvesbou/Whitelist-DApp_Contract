# Whitelist dApp - Level 8 Sophomore Track 
This code is part of the Sophomore Track from [LearnWeb3DAO](https://learnweb3.io/courses/c1d7081b-63a9-4c6e-b35c-9fcbbad418b2/lessons/acd04999-1230-4533-b6de-6b4e4978914c).

This repo contains the Smart Contract part of this project. Head over to ... for the client application.

The contract is deployed to [Goerli](https://goerli.etherscan.io/address/0x61390fc02a4c21bf4a6a60a03b287706a81b0489#code).

## Foundry instead of Hardhat
In LearnWeb3DAO Smart Contract projects are completed with Hardhat. To challenge me a little bit more and since many Web3 Veterans advocate for switching over to Foundry, I gave it a try.

## Test contract
```shell
# up to 5 v's for more verbosity in the console output

forge test -vvv
```

## Deploy contract

```shell
# To give our shell access to our environment variables
source .env
# To deploy and verify our contract
forge script script/Whitelist.s.sol:WhitelistScript --rpc-url $ALCHEMY_API_KEY_URL  --private-key $GOERLI_PRIVATE_KEY --broadcast --verify --etherscan-api-key $ETHERSCAN_API_KEY -vvvv

```