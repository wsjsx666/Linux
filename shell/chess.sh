#!/bin/bash
for i in `seq $1`
 do
 for j in `seq $2`
  do
	a=$[$i+$j]
	[ $[$a%2] -eq 0 ] && echo -ne "\033[42m  \033[0m" ||echo -ne "\033[43m  \033[0m"
	done
	echo
done
echo
