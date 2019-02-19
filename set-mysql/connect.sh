#!/bin/bash
for i in {1..5}
do
ssh 192.168.4.1$i yum -y install expect
scp mysql-pass.sh 192.168.4.1$i:/root
ssh 192.168.4.1$i /root/mysql-pass.sh
done
