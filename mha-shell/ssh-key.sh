#!/bin/bash
for i in {1..6}
do
ssh db$i yum -y install expect
scp ssh-expect.sh db$i:/root
#ssh db$i ssh-keygen  
ssh db$i /root/ssh-expect.sh
done
