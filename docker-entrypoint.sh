#!/usr/bin/env bash

if [ ! -f /app/electrum/wallets/default_wallet ] && [ ! -f /app/electrum/testnet/wallets/default_wallet ]; then
    printf "Going to setup new wallet\n"
    expect setup-wallet.sh
    bash setup-settings.sh
fi

if [ "$ELECTRUM_ENV_OVERRIDE_CONFIG" = true ] ; then
    bash setup-settings.sh
fi

printf "Going to start daemon\n"
printf "Network type >> $ELECTRUM_ENV_NETWORK_TYPE  << \n"

electrum ${ELECTRUM_ENV_NETWORK_TYPE} -D /app/electrum daemon start
sleep 2

printf "Going to load wallet\n"

#https://stackoverflow.com/questions/30106758/difference-between-braces-and-brackets-in-shell-scripting
#https://www.cyberciti.biz/faq/unix-linux-bash-script-check-if-variable-is-empty/
if [ -z "$ELECTRUM_ENV_WALLET_PASSWORD" ]
then
      echo "\$ELECTRUM_ENV_WALLET_PASSWORD is empty"
      electrum ${ELECTRUM_ENV_NETWORK_TYPE} -D /app/electrum daemon load_wallet
else
      echo "\$ELECTRUM_ENV_WALLET_PASSWORD is NOT empty"
      expect load-wallet-with-password.sh ${ELECTRUM_ENV_WALLET_PASSWORD} ${ELECTRUM_ENV_NETWORK_TYPE}
fi


echo "$@"

exec "$@"