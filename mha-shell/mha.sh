#!/bin/bash
for i in {1..6}
do
ssh db$i mkdir /root/mha
scp -r ~/桌面/08.dba1/soft/mysql/mha-soft-student/* db$i:/root/mha
done
for i in {1..6}
do
ssh db$i yum -y install ~/mha/perl-*.rpm
ssh db$i yum -y install perl-DBD-mysql
ssh db$i rpm -ivh ~/mha/mha4mysql-node-0.56-0.el6.noarch.rpm
done
scp ~/桌面/Shell1/56manage.sh db6:/root
ssh db6 yum -y install perl-ExtUtils-*   perl-CPAN*
ssh db6 tar -xf ~/mha/mha4mysql-manager-0.56.tar.gz
ssh db6 /root/56manage.sh
