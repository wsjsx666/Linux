#!/bin/bash
A=$(sed -n '/bash$/s/:.*/ /p' /etc/passwd)
for i in $A
do
pass1=$(grep $i /etc/shadow )
pass2=${pass1#*:}  #先掐头,去掉最前面的用户名字段
pass=${pass2%%:*} #后去尾,只留下密码字段               
echo "$i-->$pass" 
done
