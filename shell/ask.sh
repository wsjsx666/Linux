#!/bin/bash
x=`cat u.txt | wc -l`
while :
do 
y=$[RANDOM%$x+1]
#sed -n ""$y"p" u.txt
awk "NR==$y" u.txt
sleep 0.2
clear
done
