#!/usr/bin/env bash

trap 'exit 130' INT

sleep 3

URL="${ELECTRUM_RPC_HOST}:${ELECTRUM_RPC_PORT}"

while true; do
    echo "[$(date)] Running check script..."

    python3 /el-scripts/check.py -url=${URL} --login=${ELECTRUM_RPC_USER} --pwd=${ELECTRUM_RPC_PASSWORD}

    sleep 3
done
