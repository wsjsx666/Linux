#!/bin/bash
u=$(awk -F: '/bash$/{print $1}' /etc/passwd)
for i in $u
do
#截取字符串的方法
#p=$(grep $i /etc/shadow)
#pass1=${p#*:}
#pass2=${pass1%%:*}
#echo "$i-->$pass2" >> save.txt
#done

#awk方法
#awk -F: "/^$i/" /etc/shadow | awk -F: '{print $1,"-->",$2 }' >>  save.txt
awk -F: '/^"$i"/{print $1,"-->",$2 }'  /etc/shadow  >>  save.txt
done
