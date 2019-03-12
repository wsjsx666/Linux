#!/bin/bash
yum -y install gcc* pcre-devel curl-devel
useradd -s /sbin/nologin zabbix
tar -xf /root/zabbix-3.4.4.tar.gz
cd zabbix-3.4.4
./configure --enable-agent --with-net-snmp --with-libcurl --prefix=/usr/local/zabbix
make && make install
cp misc/init.d/fedora/core/zabbix_agentd /etc/init.d/
chmod +x /etc/init.d/zabbix_agentd
sed -i '22s#=.*#=/usr/local/zabbix#' /etc/init.d/zabbix_agentd
#ip=`ifconfig eth0|awk 'NR==2{print $2}'`
sed -i "93s/=.*/=127.0.0.1,192.168.4.11/" /usr/local/zabbix/etc/zabbix_agentd.conf
sed -i "134s/=.*/=192.168.4.11:10051/" /usr/local/zabbix/etc/zabbix_agentd.conf
sed -i '1a EnableRemoteCommands=1' /usr/local/zabbix/etc/zabbix_agentd.conf
sed -i '1a UnsafeUserParameters=1 ' /usr/local/zabbix/etc/zabbix_agentd.conf
/etc/init.d/zabbix_agentd start
ss -ntulp|grep 10050
if [ $? -ne 0 ];then
zabbix_agentd
/etc/init.d/zabbix_agentd stop
/etc/init.d/zabbix_agentd start
fi
chkconfig zabbix_agentd on




