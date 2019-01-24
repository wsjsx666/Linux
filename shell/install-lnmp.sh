read -p '请移动到nginx源码目录下,输入0确认' a
[ $a -eq 0 ] || exit
useradd -s /sbin/nologin nginx
yum -y install gcc openssl-devel pcre-devel
./configure --user=nginx --group=nginx --with-http_ssl_module --with-stream --with-http_stub_status_module
make && make install
cp -a ~/php-fpm-5.4.16-42.el7.x86_64.rpm .
yum -y install php php-mysql 
yum -y install php-fpm-5.4.16-42.el7.x86_64.rpm
systemctl stop httpd
ln -s /usr/local/nginx/sbin/nginx /sbin/nginx
nginx 
systemctl start php-fpm
systemctl enable php-fpm
setenforce 0
yum -y install mariadb-server mariadb mariadb-devel
systemctl start mariadb
systemctl enable mariadb

