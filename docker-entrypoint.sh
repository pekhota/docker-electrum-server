#!/usr/bin/env bash

if [ ! -f /app/electrum/wallets/default_wallet ]; then
    printf "Going to setup new wallet\n"
    expect setup-wallet.sh
    bash setup-settings.sh
fi

printf "Going to start daemon\n"
printf "Network type >> $ELECTRUM_ENV_NETWORK_TYPE  << \n"

electrum ${ELECTRUM_ENV_NETWORK_TYPE} -D /app/electrum daemon start
printf "Going to load wallet\n"
electrum ${ELECTRUM_ENV_NETWORK_TYPE} -D /app/electrum daemon load_wallet

echo "$@"

exec "$@"