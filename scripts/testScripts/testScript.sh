#!/bin/bash

echo "testScript"

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
