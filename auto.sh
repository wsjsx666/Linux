#!/bin/bash
read -p "请输入对方IP" ip
curl ftp://$ip
if [$? -ne 0 ];then
iscsiadm --mode discoverydb --type sendtargets --portal 192.168.4.5 --discover
systemctl start iscsi
mount /dev/sda1 /mnt
systemctl start vsftpd
