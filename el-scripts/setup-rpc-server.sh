#!/usr/bin/env bash

if [[ -z ${ELECTRUM_NETWORK} ]]; then
  electrum -D ${ELECTRUM_PATH} setconfig rpchost ${ELECTRUM_RPC_HOST}
  electrum -D ${ELECTRUM_PATH} setconfig rpcport ${ELECTRUM_RPC_PORT}
  electrum -D ${ELECTRUM_PATH} setconfig rpcuser ${ELECTRUM_RPC_USER}
  electrum -D ${ELECTRUM_PATH} setconfig rpcpassword ${ELECTRUM_RPC_PASSWORD}
else
  electrum ${ELECTRUM_NETWORK} -D ${ELECTRUM_PATH} setconfig rpchost ${ELECTRUM_RPC_HOST}
  electrum ${ELECTRUM_NETWORK} -D ${ELECTRUM_PATH} setconfig rpcport ${ELECTRUM_RPC_PORT}
  electrum ${ELECTRUM_NETWORK} -D ${ELECTRUM_PATH} setconfig rpcuser ${ELECTRUM_RPC_USER}
  electrum ${ELECTRUM_NETWORK} -D ${ELECTRUM_PATH} setconfig rpcpassword ${ELECTRUM_RPC_PASSWORD}
fi
