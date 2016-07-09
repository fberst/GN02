#!/bin/bash

#creat's .img file to dd on sd
echo "makeImage"
RESERVE=400000
echo "ROOT SIZE:     $(du -s ${ROOT} | cut -d'	' -f1)"
echo "BOOT SIZE:     ${IMGBOOTSIZE}"
echo "XCR DATA SIZE: $(du -s ${XCSoarData} | cut -d'	' -f1)"
echo "RESERVE:       ${RESERVE}"
IMGSIZE=$(( $(du -s ${ROOT} | cut -d'	' -f1) + $(du -s ${XCSoarData} | cut -d'	' -f1) + ${IMGBOOTSIZE} + ${RESERVE} ))
echo "IMG SIZE:      ${IMGSIZE}"
IMGSIZE=$(( ${IMGSIZE} * 1024 ))
[ -z ${IMGSIZE} ] && exit 1
dd if=/dev/zero of=${IMG} count=$((${IMGSIZE} / 512)) || exit 1
#dd if=/dev/zero of=${IMG} count=$((${IMGESIZE} / 512))
export LOOP=$(losetup -P -f --show ${IMG})
[ -z ${LOOP} ] && exit 1
echo ${LOOP}

