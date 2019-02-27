#!/bin/bash
for i in {51..56}
do
scp ~/08.dba1/soft/redis/redis-4.0.8.tar.gz 192.168.4.$i:/root
ssh 192.168.4.$i \
"yum -y install gcc gcc-c++ make expect
tar -xf redis-4.0.8.tar.gz 
cd redis-4.0.8/
make && make install
cd utils/
expect<<EOF
spawn ./install_server.sh
expect ""6379]"" {send ""\r""}
expect ""conf]"" {send ""\r""}
expect "".log]""  {send ""\r""}
expect ""/6379]"" {send ""\r""}
expect ""server]"" {send ""\r""}
expect ""abort."" {send ""\r""}
expect ""#"" {send "exit"\r""}
EOF
ss -ntulp | grep :6379
[ $? -eq 0 ]&& echo 'redis启动成功' ||echo '搭建失败,请调试!'
sed -i '/port 6379/c "port 63$i"' /etc/redis/6379.conf
sed -i '/bind/s/127.0.0.1/192.168.4.${i}/' /etc/redis/6379.conf
sed -i '/pidfile \/var/run/redis_6379.pid/s/6379/63${i}/' /etc/redis/6379.conf
sed -i '/cluster-enabled/s/\#//' /etc/redis/6379.conf
sed -i '/cluster-config-file/c cluster-config-file nodes-63${i}.conf' /etc/redis/6379.conf
sed -i '/cluster-node-timeout/c cluster-node-timeout 5000' /etc/redis/6379.conf
/etc/init.d/redis_6379 start
ss -antlp | grep 63$i
sleep 2
"
done

