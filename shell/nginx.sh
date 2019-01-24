#!/bin/bash
#安装
a=`yum repolist | awk '/repolist/{print $2}'| sed 's/,//'`
[ $a -gt 0 ] && echo 'yum可用' || echo 'yum不可用' || exit 
rpm -q gcc openssl-devel pcre-devel &>/dev/null
[ $? -eq 0 ]||yum -y install gcc openssl-devel pcre-devel 
tar -xf nginx-1.12.2.tar.gz
cd nginx-1.12.2
if [ ! -e /usr/local/nginx ] ;then
./configure
make
make install
fi
#启动及状态检测
case $1 in
start)
/usr/local/nginx/sbin/nginx;;
stop)
/usr/local/nginx/sbin/nginx -s stop ;;
restart)
/usr/local/nginx/sbin/nginx -s stop
/usr/local/nginx/sbin/nginx ;;
status)
 netstat -ntulp|grep -q nginx
 [ $? -eq 0 ] && echo '服务已启动' || echo '服务未启动';;
*)
echo "请按照输入格式 ./$0 start|stop|restart|status"
exit;;
esac
#监测脚本
echo -e  "\033[46m以下开始输出本机性能信息\033[0m"
CPU=`uptime|awk '{print $NF}'`
echo "本机CPU每15分钟平均负载;$CPU"
ain=`ifconfig eth0 | awk '/RX p/{print $5}'`
aout=`ifconfig eth0 | awk '/TX p/{print $5}'`
echo "本机入网流量:$ain"
echo "本机出站流量:$aout"
mem=`free -m | awk '/Mem/{print $4}'`
echo "本机磁盘剩余容量:$mem M"
mem1=`df -h | awk '/\/$/{print$4}'`
echo "根分区可用容量:$mem1"
users=`cat /etc/passwd | wc -l`
echo "本机账户数量:$users"
log=`who|wc -l`
echo "当前登录用户数:$log"
pro=`ps aux |wc -l`
echo "本机当前开启进程数量:$pro"
app=`rpm -qa | wc -l`
echo "本机已安装软件包数量:$app"
#安全控制
awk  '/Failed password for root/{ip[$11]++}END{for(i in ip){print "登录本机失败的IP:",i,"失败次数:",ip[i]}}' /var/log/secure
awk '/Invalid/{user[$8]++}END{for(i in user){print "登录本机失败的用户:",i,"失败次数:",user[i]}}' /var/log/secure

