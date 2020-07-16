#!/bin/bash
for i in {2,10}
do
scp ~/redis-5.0.9.tar.gz 192.168.1.$i:/root/
ssh 192.168.1.$i \
"yum -y install gcc gcc-c++ make expect
tar -xf /root/redis-5.0.9.tar.gz
cd /root/redis-5.0.9
make && make install
cd utils/
expect <<EOF
spawn ./install_server.sh
expect ""6379]"" {send ""\r""}
expect ""conf]"" {send ""\r""}
expect "".log""  {send ""\r""}
expect ""/6379"" {send ""\r""}
expect ""server"" {send ""\r""}
expect ""abort."" {send ""\r""}
expect ""#""     {send ""exit\r""}
EOF
netstat -ntlp|grep :6379
[ $? -eq 0 ] && echo 'redis,SUCCESS' || echo 'ERROR,Plz check'
sed -i '/^port 6379/c "port 63$i"' /etc/redis/6379.conf
sed -i '/^bind/s/127.0.0.1/192.168.1.${i}/' /etc/redis/6379.conf
sed -i '/pidfile \/var\/run\/redis_6379.pid/s/6379/63${i}/' /etc/redis/6379.conf
sed -i '/cluster-enabled/s/#//' /etc/redis/6379.conf
sed -i '/cluster-config-file/c cluster-config-file nodes-63${i}.conf' /etc/redis/6379.conf
sed -i '/cluster-node-timeout/c cluster-node-timeout 5000' /etc/redis/6379.conf
mv /etc/redis/6379.conf /etc/redis/63${i}.conf
sed -i 's/6379/63${i}/g' /etc/init.d/redis_6379
mv /etc/init.d/redis_6379 /etc/init.d/redis_63${i}
/etc/init.d/redis_63${i} start
netstat -ntlp|grep 63${i}
sleep 2
"
done
