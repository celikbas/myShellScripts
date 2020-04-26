export MOUNTPOINT = /home/zeki/bagla/lampp32/
# check if VPN is working
# alternate check: if (ps aux | grep vpnui | grep -v grep > /dev/null);  then
if (ifconfig cscotun0 | grep -q "00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00"); then
    echo VPN is RUNNING.
else
    echo VPN is not RUNNING exiting...
    exit
fi

# check if mountpoint is emty 
# alternate: if grep -qs $MOUNTPOINT /proc/mounts; then
# alternate: use mount command
if (df | grep -qs $MOUNTPOINT); then
    echo "It's mounted."
else
    echo "It's not mounted. Mounting:"
    # connect to mountpoint
    sshfs zeki@kitaplik:$MOUNTPOINT $MOUNTPOINT
fi

# make tunnell to virtual machine on remote server
if (nc -z -v -w5 localhost 12345) &> /dev/null; then
    echo Tunnel connection established.
else
    echo Creating tunnel to remote server...
    # make the tunnel:
    ssh -o ExitOnForwardFailure=yes -fN -L 12345:192.168.122.133:80 zeki@kitaplik
fi

arr[0]="Now go to Work"
arr[1]="Mmmm what will happen now?"
arr[2]="Will you really work?"

rand=$[ $RANDOM % 3 ]
echo ${arr[$rand]}

