#!/bin/bash
rpm -q vsftpd  &> /dev/null
[ $? -eq  0 ]||yum -y install vsftpd
sed -i 's/^#anon/anon/' /etc/vsftpd/vsftpd.conf
[ -e /var/ftp/pub ] || mkdir /var/ftp/pub
chmod 777 /var/ftp/pub #按需修改
systemctl start vsftpd
systemctl enable vsftpd
