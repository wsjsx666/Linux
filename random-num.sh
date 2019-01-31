read -p "请输入所需随机数的范围:" r
while :
do
echo -n $[RANDOM%$r+1]
sleep 0.1
clear
done
