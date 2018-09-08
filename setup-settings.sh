#!/usr/bin/env bash

#https://stackoverflow.com/questions/5750450/print-each-command-before-executing/5750463#5750463
set -o xtrace

electrum ${ELECTRUM_ENV_NETWORK_TYPE} -D /app/electrum setconfig rpchost 0.0.0.0
electrum ${ELECTRUM_ENV_NETWORK_TYPE} -D /app/electrum setconfig rpcport 7777
electrum ${ELECTRUM_ENV_NETWORK_TYPE} -D /app/electrum setconfig rpcuser user
electrum ${ELECTRUM_ENV_NETWORK_TYPE} -D /app/electrum setconfig rpcpassword ssow6Qc-kKwycQ_1SeVXVQ==