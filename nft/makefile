# include .env file and export its env vars
-include .env

# Builds
build:
	@forge clean && forge build --optimize --optimizer-runs 1000000

# Deployment
deploy:
	@forge create Counter --private-key ${PRIVATE_KEY} --rpc-url ${RPC_URL}