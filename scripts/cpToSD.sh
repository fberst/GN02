#!/bin/bash

copyToSD() {
	info "copy / \"root\" to SD"
	DEV=$1
	[[ $(blkid ${DEV}${RP}) != *"TYPE=\"ext4\""* ]] && echo "error setup disk first" && exit 1
	mountDev ${DEV} ${MNTROOT}
	rsync -avx --delete ${ROOT} ${MNTROOT}
	echo "sync"
	sync
	umountDev ${TDEV} ${MNTROOT}
	
	info "dd uBoot to SD"
	umountDev ${DEV}"${BP}" "NULL"
	dd if=${BOOT}/sunxi-spl.bin of=${DEV} bs=1024 seek=8 #TODO BOOT | UBOOT
	dd if=${BOOT}/u-boot.bin of=${DEV} bs=1024 seek=32	#TODO BOOT | UBOOT
	mkfs.vfat ${DEV}${BP}

	info "cp kernel & boot data to SD"
	mountDev ${DEV} ${MNTBOOT}
	mv ${MNTBOOT}"/uImage" ${MNTBOOT}"/uImage.bak" #backup old kernel
	cp ${BOOT}* ${MNTBOOT}
	echo "sync"
	sync
	umountDev ${DEV} "NULL"
	unset DEV
}
