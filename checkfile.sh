#!/bin/bash
read -p '请输入模块名：'  name
if [ $name = "billing" -o $name = "billing-mop-svc" -o $name = "billing-mop-web" ];then
  read -p '请输入JIRA（-svc.war）文件大小：' size
  realsize=$(ls -ltr `date +%Y%m%d`_${name}/ |awk /\(war\)$/'{print $5}')
  echo "Realsize(war包)=$realsize"
  sleep 1
  [ $realsize -ne $size ] || echo 'YES' && echo 'ERROR,plz check'
elif [ $name = "phub" ];then
  read -p '请输入JIRA（phub-svc.war）文件大小：' wsize
  read -p '请输入JIRA（phub.tar）文件大小:' tsize
  realwsize=$(ls -ltr `date +%Y%m%d`_${name}/ |awk /\(war\)$/'{print $5}')
  realtsize=$(ls -ltr `date +%Y%m%d`_${name}/ |awk /\(tar\)$/'{print $5}')
  echo "Realsize(phub-svc.war)=$realwsize"
  echo "Realsize(phub.tar)=$realtsize"
  sleep 1
  [ $realwsize -eq $wsize ] && echo 'YES,continue to work' || echo 'ERROR in phub-svc.war,plz check'
  [ $realtsize -eq $tsize ] && echo 'YES,continue to work' || echo 'ERROR in phub.tar,plz check'
else
  echo "Usage: $0,请键入正确模块名！"
fi
