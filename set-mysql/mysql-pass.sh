#!/bin/bash
systemctl start mysqld
p=`awk '/A temporary/{print $11}' /var/log/mysqld.log`
#可加入其他预配置
#server_id=*
#log-bin
#####半同步复制
#plugin-load ="rpl_semi_sync_master=semisync_master.so;rpl_semi_sync_slave=semisync_slave.so"
#rpl-semi-sync-master-enabled = 1
#rpl-semi-sync-slave-enabled = 1             #####   
sed -i '/\[mysqld\]/a validate_password_policy=0\nvalidate_password_length=6' /etc/my.cnf
systemctl restart mysqld
systemctl enable mysqld
expect<<EOF
spawn mysql -uroot -p$p
expect "mysql>" {send "alter user root@localhost identified by '123456';\r"}
expect "mysql>" {send "exit\r"}
expect "#"        {send "exit\r" }
EOF
mysql -uroot -p123456 -e"show databases;"
[ $? -eq 0 ] && echo '改密成功!可正常使用!'|| echo '失败!请检查ip及文件是否完整'
