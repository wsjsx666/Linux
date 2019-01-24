#!/bin/bash
jindu(){
while :
do
    echo -ne '\033[43m \033[0m'
		sleep 0.3
		done
		    }
jindu &
yum -y install bind bind-chroot &>/dev/null
kill $!
echo
echo "执行完毕!"
