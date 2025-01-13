# include .env file and export its env vars
-include .env

# Builds
build:
	@forge clean && forge build --optimize --optimizer-runs 1000000

# Deployment
deploy:
	@forge script script/GenesisNFT.s.sol --rpc-url ${RPC_URL} --private-key ${PRIVATE_KEY}