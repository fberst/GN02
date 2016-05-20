#!/bin/bash

echo "testScript"

tx=(
1 #test
2
3
4
5
)

echo ${tx[@]}

exit 0

trap free 2
echo "XX"
sleep 10
echo "##"

exit 0

DEV=/dev/loop1p1
MNT=/mnt

mount ${DEV} ${MNT}


#echo "\"root\""
exit 0

#[ -x config.sh ] && echo "config"
#[ $? -eq 1 ] && echo "error"

mv config.sh config.sh.s

[ $? != 0 ] && echo "erroer"

echo $?

echo "end"
