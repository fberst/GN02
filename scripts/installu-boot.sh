#!/bin/bash
echo "dd uBoot to SD"
[ -b ${SD} ] || exit 1
dd if=${BOOT}/sunxi-spl.bin of=${SD} bs=1024 seek=8 #TODO BOOT | UBOOT
dd if=${BOOT}/u-boot.bin of=${SD} bs=1024 seek=32   #TODO BOOT | UBOOT
#mkfs.vfat ${BOOTBD}
