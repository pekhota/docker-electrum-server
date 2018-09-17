#!/usr/bin/env bash

if [[ -z ${ELECTRUM_NETWORK} ]]; then
  electrum -D ${ELECTRUM_PATH} daemon start
else
  electrum ${ELECTRUM_NETWORK} -D ${ELECTRUM_PATH} daemon start
fi
