#!/bin/bash
date=`date +%Y%m%d`
path=/usr/local/nginx/logs
mv $path/access.log $path/access-$date.log
mv $path/error.log $path/error-$date.log
id=`cat $path/nginx.pid`
kill -USR1 $id
