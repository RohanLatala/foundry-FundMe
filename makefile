-include.env

deploy-mainnet:
forge script script/DeployFundMe.s.solDeployFundMe --rpc-url $(MAINNET_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv
