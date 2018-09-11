#!/usr/bin/env bash

trap 'exit 130' INT

sleep 3

AUTHORIZATION="$(echo -n ${ELECTRUM_RPC_USER}:${ELECTRUM_RPC_PASSWORD} | base64)"
URL="${ELECTRUM_RPC_HOST}:${ELECTRUM_RPC_PORT}"

while true; do
    ELECTRUM_GET_BALANCE_RESPONSE=$(curl -s -m ${ELECTRUM_WATCHER_TIMEOUT} -X POST "${URL}" -H "Authorization: Basic ${AUTHORIZATION}" -H 'Content-Type: application/json' -d '{ "id": 0, "method": "getbalance", "params": [] }' | jq '.result.confirmed')
    ELECTRUM_DAEMON_STATUS_RESPONSE=$(curl -s -m ${ELECTRUM_WATCHER_TIMEOUT} -X POST "${URL}" -H "Authorization: Basic ${AUTHORIZATION}" -H 'Content-Type: application/json' -d '{ "id": 0, "method": "daemon", "params": {"config_options": {"subcommand": "status"}} }' | jq '.result.connected')

    if [[ ${ELECTRUM_DAEMON_STATUS_RESPONSE} != "true" || ${ELECTRUM_GET_BALANCE_RESPONSE} == "" ]]; then
        echo "[$(date)] There is something wrong with Electrum"
        exit 1 # terminate and indicate error
    else
        echo "[$(date)] Ok..."
    fi

    sleep 3
done
