#!/bin/bash
read -p '请输入用户名:' a
[ -z $a ] &&echo "输入为空,请重新操作" && exit 3
stty -echo
read -p '请输入密码:' b
stty echo
b=${b:-123456}
useradd $a
echo -e "\n"
echo $b | passwd --stdin $a
