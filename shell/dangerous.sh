#!/bin/bash
a=$(who | wc -l)
[ $a -gt 3  ] && echo sb | mail -s "dangerous!" root@localhost 
