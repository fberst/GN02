#!/bin/bash

#format disk

TDEV=$1
[ ${UID} -eq 0 ] || exit 1
[ -b ${TDEV} -o ${TDEV} != *".img" ] || exit 1

parted -s ${TDEV} mklabel msdos	
parted -s -a optimal ${TDEV} mkpart p ext2 2MiB 100MiB	#mke boot 
parted -s -a optimal ${TDEV} mkpart p ext2 100MiB 100%	#make root
parted -s ${TDEV} print
unset TDEV

