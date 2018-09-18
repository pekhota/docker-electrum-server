#!/usr/bin/env bash

# 0. make sure all the environment variables exist
VARS=(ELECTRUM_WATCHER_TIMEOUT ELECTRUM_PATH ELECTRUM_WALLET_PASSWORD ELECTRUM_NETWORK ELECTRUM_RPC_HOST ELECTRUM_RPC_PORT ELECTRUM_RPC_USER ELECTRUM_RPC_PASSWORD)

for VAR in "${VARS[@]}"
do
  if [ $(env | grep "^${VAR}" -c) -eq 0 ];
  then
    echo -e "\n**** ---- The environment variable ${VAR} is not set. Exiting. ****\n"
    exit 1
  fi
done

# 1. check if a wallet is already present
if [ ! -f ${ELECTRUM_PATH}/wallets/default_wallet ] && [ ! -f ${ELECTRUM_PATH}/testnet/wallets/default_wallet ]; then
    echo -e "\n**** ---- No wallet found. Creating one. ****\n"
    # 2. no wallet present, so create a new one
    expect /el-scripts/create-wallet.exp
else
    echo -e "\n**** ---- A wallet has been found. ****\n"
fi

echo -e "\n**** ---- Configuring RPC Server. ****\n"

# 3. configure rpc server credentials
bash /el-scripts/setup-rpc-server.sh

echo -e "\n**** ---- Getting daemon running. ****\n"

# 4. get daemon running
bash /el-scripts/start-daemon.sh 

echo -e "\n**** ---- Loading wallet. ****\n"

# 5. load wallet
expect /el-scripts/load-wallet.exp
[ $? -ne 0 ] && echo -e "\n**** ---- Failed to load wallet. ****\n" && exit 1

# 6. don't let the container die
bash /el-scripts/healthcheck.sh
