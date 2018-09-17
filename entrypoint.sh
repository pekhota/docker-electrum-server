#!/usr/bin/env bash

# 1. check if a wallet is already present
if [ ! -f ${ELECTRUM_PATH}/wallets/default_wallet ] && [ ! -f ${ELECTRUM_PATH}/testnet/wallets/default_wallet ]; then
    echo -e "\n**** No wallet found. Creating one. ****\n"
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

# 6. don't let the container die
bash /el-scripts/healthcheck.sh
