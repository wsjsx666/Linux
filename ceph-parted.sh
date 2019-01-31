#!/bin/bash
for i in node{1..3}
 do
   ssh $i parted /dev/vdb mklabel gpt
	 ssh $i parted /dev/vdb mkpart primary 1M 50%
	 ssh $i parted /dev/vdb mkpart primary 50% 100%
	 ssh $i chown ceph:ceph /dev/vdb?
   ssh $i  echo -e 'ENV{DEVNAME}=="/dev/vdb1",OWNER="ceph",GROUP="ceph"\nENV{DEVNAME}=="/dev/vdb2",OWNER="ceph",GROUP="ceph"'> /etc/udev/rules.d/vdb.rules
 done
for j in {1..3}
  do
	  ceph-deploy disk  zap  node$j:vdc   node$j:vdd
		ceph-deploy osd create node$j:vdc:/dev/vdb1 node$j:vdd:/dev/vdb2
  done
systemctl restart ceph\*.service ceph\*.target
#node1 mon错误解决(非必须)
systemctl reset-failed ceph-mon@node1.service
systemctl restart ceph-mon@node1.service
ceph -s
