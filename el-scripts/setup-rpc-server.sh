#!/usr/bin/env bash

electrum ${ELECTRUM_NETWORK} -D ${ELECTRUM_PATH} setconfig rpchost ${ELECTRUM_RPC_HOST}
electrum ${ELECTRUM_NETWORK} -D ${ELECTRUM_PATH} setconfig rpcport ${ELECTRUM_RPC_PORT}
electrum ${ELECTRUM_NETWORK} -D ${ELECTRUM_PATH} setconfig rpcuser ${ELECTRUM_RPC_USER}
electrum ${ELECTRUM_NETWORK} -D ${ELECTRUM_PATH} setconfig rpcpassword ${ELECTRUM_RPC_PASSWORD}
