#! /bin/bash
while :
do
	a=`date +%M`
	b=$((a%10))
	if [ $b -eq 0 ];then
		`systemctl stop firewalld`
		`systemctl restart sshd`
	else
		sleep 60s
	fi
done
