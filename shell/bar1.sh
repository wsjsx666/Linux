#!/bin/bash
go(){
t=0.2
c=0
while :
do
let c++
case $c in
1)
echo -e '-'"\b\c"
sleep $t;;
2)
echo -e '\\'"\b\c"
sleep $t;;
3)
echo -e '|'"\b\c"
sleep $t;;
4)
echo -e '/'"\b\c"
sleep $t;;
*)
c=0;;
esac
done
}
go
