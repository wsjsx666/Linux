#!/bin/bash
while inotifywait -rq /opt 
do
rsync -az --delete /opt/ root@192.168.4.207:/opt
done
