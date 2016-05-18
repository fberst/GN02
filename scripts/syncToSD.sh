#!/bin/bash

copyToSD() {
	
	echo "copy / \"root\" to SD"
	rsync -avx --delete ${ROOT} ${MNTROOT}
	echo "sync"
	sync

	./umount.sh 
	
	echo "dd uBoot to SD"
	dd if=${BOOT}/sunxi-spl.bin of=${SD} bs=1024 seek=8 #TODO BOOT | UBOOT
	dd if=${BOOT}/u-boot.bin of=${SD} bs=1024 seek=32   #TODO BOOT | UBOOT
	mkfs.vfat ${BOOTBD}

	echo "cp kernel & boot data to SD"
	./mount.sh
	mv ${MNTBOOT}"/uImage" ${MNTBOOT}"/uImage.bak" #backup old kernel
	cp ${BOOT}/* ${MNTBOOT}
	echo "sync"
	sync
	./umount.sh
}
