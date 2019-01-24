#!/bin/bash
for ((i=1;i<=9;i++))
 do
 for ((j=1;j<=i;j++))
  do
	echo -n $i
	done
	echo 
done
read  -n1 -p '按任意键继续' a
clear
for ((i=1;i<=5;i++))
 do
 for ((j=1;j<=i;j++))
  do
	echo -n '|'
	done
  echo -n '_'
echo
done
read -n1 -p '按任意键继续' b
for ((i=1;i<=5;i++))
do
 for ((j=1;j<=i;j++))
 do
 echo -n '*'
 done
 echo
done
for ((i=5;i>=1;i--))
do
 for ((j=1;j<=i;j++))
 do
 echo -n '*'
 done
 echo
done
