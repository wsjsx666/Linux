#!/bin/bash
bar(){
while :
do
echo -n '#'
sleep 0.2
done
}
bar &
cp -a $1 $2
killall $!
echo 'cp finish!'

