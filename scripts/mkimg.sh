#!/bin/bash

makeImage() { #creat's .img file to dd on sd
	echo "makeImage"
	#IMAGESIZE="2000M" #set image size to 2GB
	BOOTSIZE=100000000
	IMAGESIZE=$(($(du -s ${ROOT} | cut -d'	' -f1) +$BOOTSIZE + 100000000))
	ddProgress if=/dev/zero of=${IMG} count=$((${IMGESIZE} / 512))
	#dd if=/dev/zero of=${IMG} count=$((${IMGESIZE} / 512))
	LOOP=$(losetup -P -f --show ${IMG})
	formatSD ${LOOP}
	copyToSD ${LOOP}
	losetup -d ${LOOP}
}
