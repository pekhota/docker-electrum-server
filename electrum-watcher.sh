#!/usr/bin/env bash

#https://stackoverflow.com/questions/5750450/print-each-command-before-executing/5750463#5750463
set -o xtrace

trap 'exit 130' INT

URL="localhost:7777"
TIMEOUT=3
AUTHORIZATION_TOKEN="dXNlcjpzc293NlFjLWtLd3ljUV8xU2VWWFZRPT0="

sleep 3

while true; do
    ELECTRUM_DAEMON_RESPONSE=$(curl -s -m ${TIMEOUT} -X POST ${URL} -H "Authorization: Basic ${AUTHORIZATION_TOKEN}" -H 'Content-Type: application/json' -d '{ "id": 0, "method": "daemon", "params": {"config_options": {"subcommand": "status"}} }' | jq '.result.connected')

    if [[ ${ELECTRUM_DAEMON_RESPONSE} != "true" ]]; then
        echo "[$(date)] Looks like the daemon is down"
        exit 1 # terminate and indicate error
    else
        echo "[$(date)] Ok..."
    fi

    sleep 1
done
