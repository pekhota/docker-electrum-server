#!/usr/bin/expect

#http://www.admin-magazine.com/Articles/Automating-with-Expect-Scripts
#https://unix.stackexchange.com/questions/378083/how-to-redirect-output-to-a-log-from-expect-command
#https://www.thegeekstuff.com/2010/10/expect-examples/

set timeout -1
log_file expect.log
spawn electrum ${ELECTRUM_ENV_NETWORK_TYPE} -D /app/electrum create
expect "Password (hit return if you do not wish to encrypt your wallet):" { send "\r" }
#expect "Confirm:" { send "d0gsaremybestfr13nds\r" }

expect "Wallet saved in '/app/electrum/wallets/default_wallet'"