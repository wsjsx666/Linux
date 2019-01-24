#!/bin/bash
read -p 'Enter num:' x
a=${x//[0-9]/} 
[ ! -z $a ] && echo '输入不合法' && exit
x=${x:-1}
i=1
sum=0
while [ $i -le $x ]
do
let sum=$i+$sum
let i++
done
echo "1到$x的和为:$sum"
#for方法
#sum=0
#for i in `seq $x`
#do
#let sum+=$i
#done
#echo $sum
 

