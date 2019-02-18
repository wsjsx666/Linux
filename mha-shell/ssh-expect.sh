#!/bin/bash
ssh-keygen -N '' -f /root/.ssh/id_rsa
code(){
expect<<EOF
spawn ssh-copy-id 192.168.4.5$1
expect "(yes/no)?"  { send "yes\r" }
expect "password:"  { send "123456\r" }
expect "#"          { send "exit"\r }
EOF
}
for a in {1..6}
do
code $a 
done
