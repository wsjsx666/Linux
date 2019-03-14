#!/bin/bash
pd=`pwd`
if [ $pd !=  /var/lib/libvirt/images ];then
cd /var/lib/libvirt/images
fi
pwd
read -n1 -p '创建单个虚拟机y,多个n:' k
case $k in
Y | y )
read -p '所需虚拟机名称:'  n1
read -p '所需大小(单位为G,默认20G):' m 
qemu-img create -b node.qcow2 -f qcow2 ${n1}.img ${m:-20}G
cd /etc/libvirt/qemu
sed  "s/node/${n1}/" node.xml > ${n1}.xml
#sed  -i "/<source file/s/node/${n1}/" ${n1}.xml
virsh define ${n1}.xml
virsh dominfo ${n1}
sleep 2
;;
n | N )
read -p '请输入需要创建的虚拟机基本名:' a
read -p '虚拟机编号范围start:' x
read -p '虚拟机编号范围end:' y
read -p '所需大小(单位为G,默认20G):' m
for i in `seq $x $y`
do
cd /var/lib/libvirt/images
qemu-img create -b node.qcow2 -f qcow2 ${a}${i}.img ${m:-20}G
cd /etc/libvirt/qemu
sed  "s/node/${a}${i}/" node.xml > ${a}${i}.xml
#sed  -i "/<source file/s/node/${a}${i}/"    ${a}${i}.xml
virsh define ${a}${i}.xml
done
virsh list --all
;;
*)
echo '操作错误,请重新运行' && exit
;;
esac

