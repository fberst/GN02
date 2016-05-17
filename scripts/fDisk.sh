#!/bin/bash

#format disk

TDEV=$1

#[ -b ${TDEV} -o ${TDEV} != *".img" ] || exit 1

[ -b ${TDEV} ] || exit 1

echo "part"
parted -s ${TDEV} mklabel msdos							#mktable
parted -s -a optimal ${TDEV} mkpart p ext2 2MiB 100MiB		#mke boot 
parted -s -a optimal ${TDEV} mkpart p ext2 100MiB 100%	#make root
parted -s ${TDEV} print									
echo "format"
mkfs.ext4 ${ROOTBD}
unset TDEV

