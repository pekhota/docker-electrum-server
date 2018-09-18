#!/usr/bin/env bash

trap 'exit 130' INT

sleep 3

URL="${ELECTRUM_RPC_HOST}:${ELECTRUM_RPC_PORT}"

while true; do
    echo "[$(date)] Running check script..."

    python3 /el-scripts/check.py --url="${URL}" --login="${ELECTRUM_RPC_USER}" --pwd="${ELECTRUM_RPC_PASSWORD}"
    [ $? -ne 0 ] && echo -e "\n**** ---- Failed to ping electrum. ****\n" && exit 1

    sleep 3
done
