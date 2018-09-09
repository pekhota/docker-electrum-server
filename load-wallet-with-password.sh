#!/usr/bin/expect -f

#https://www.thegeekstuff.com/2010/10/expect-examples/
set password [lindex $argv 0]
set network [lindex $argv 1]
spawn electrum ${network} -D /app/electrum daemon load_wallet
expect "Password:"
send "$password\r";
expect "true"
interact