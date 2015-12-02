#!/bin/bash
if [ -z "$SUDO_USER" ]; then
    echo "$0 must be called from sudo. Try: 'sudo ${0}'"
    exit 1
fi

SCRIPT_LOCATION="/etc/network/if-up.d/komey_socks_proxy"

apt-get -y install expect

echo "Creating file in $SCRIPT_LOCATION"
echo "Randomly creating port numbers (edit these in the file to change if you want)"

PORT_NUMBER=$[ ( $RANDOM % 10000 )  + 10000 ]

echo "PORT_NUMBER: ${PORT_NUMBER}"

echo "Enter servername or IP address for the remote server"
read REMOTE_SERVER
echo "Enter username to use for logging into $REMOTE_SERVER:[$SUDO_USER]"
read REMOTE_USERNAME
echo "Enter password to $REMOTE_USERNAME"
read REMOTE_PASSWD

if [[ -z $REMOTE_USERNAME ]]; then
  REMOTE_USERNAME=$SUDO_USER
fi
echo "#!/usr/bin/expect -f
# ------------------------------
# Added by Komey
# ------------------------------
set timeout -1
spawn ssh -4 -D $PORT_NUMBER $REMOTE_USERNAME@$REMOTE_SERVER 
expect {
    \"yes/no\" { send \"yes\r\";exp_continue}
    \"password:\" {send \"$REMOTE_PASSWD\r\";exp_continue}
    }
expect eof   
" > $SCRIPT_LOCATION


chmod +x $SCRIPT_LOCATION

echo "Checking to see if we can login: ssh $REMOTE_USERNAME@$REMOTE_SERVER"
echo "Do you want to start the proxy now? [y]/n"
read START_PROXY

if [ ! "${START_PROXY}" = "n" ]; then
  $SCRIPT_LOCATION &
fi
netstat -lnp | grep $PORT_NUMBER