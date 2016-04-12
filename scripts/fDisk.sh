#!/bin/bash

#format disk

TDEV=$1
umountDev ${TDEV}p* "NULL"
echo "part"
parted -s ${TDEV} mklabel msdos							#mktable
parted -s -a optimal ${TDEV} mkpart p ext2 2MiB 100MiB		#mke boot 
parted -s -a optimal ${TDEV} mkpart p ext2 100MiB 100%	#make root
parted -s ${TDEV} print									
echo "format"
mkfs.ext4 ${TDEV}$rp
unset TDEV

