SHELL := /bin/bash

######################################
#GN01 image config
#
######################################
##DEFAULTS
export SD=/dev/mmcblk2# #default sdcard
export BOOTBD=${SD}p1#  #default boot block dev
export ROOTBD=${SD}p2#  #default root block dev

export DEFAULTEDITOR=vim#       #default editor

export CLEARROOT=false#  #clear root when making new $root " -mr "


export WORK=/home/florian/GN02#         #work dir
export IMAGE=${WORK}/image#            	#image dir
export BOOT=${WORK}/boot#               #boot data z.b. uImage ..
export ROOT=${WORK}/rootfs#    		#local root dir
export BUILDFS=${WORK}/buildfs#		#build fs
export SCRIPTS=${WORK}/scripts#         #bscript's to creat image
export SCRIPTBIN=${SCRIPTS}/scriptBin#  #bin2fex && fex2bin
export SRC=${WORK}/src#                 #sorcecode
export SRCKERNEL=${SRC}/linux-sunxi# 	#kernel src #TODO
export SRCUBOOT=${SRC}/u-boot#   	#uBoot src #TODO
export RES=${WORK}/res#                 #resorces
export DEB=${RES}/deb#                  #.deb for auto install 
export FILES=${RES}/files#              #fils to install z.b. sudoers
export LIB=${RES}/lib#                  #mali .so fils z.b. Mali.so, libEGL.so

export MNTROOT=${WORK}/mnt/root#             	#root mount point
export MNTBOOT=${WORK}/mnt/boot#		#boot mount point

#PATHS to FILS
export IMG=${IMAGE}/gn01.img#

#default pardischen
export BP=p1#   #boot pard
export RP=p2#   #root pard

SC=${SCRIPTS}

mk_rootfs:
	${SC}/mk-rootfs.sh

mk_buildfs:
	${SC}/mk-buildfs.sh

chrootL:
	${SC}/chroot.sh ${ROOT}

chrootSD: mountall
	${SC}/chroot.sh ${MNTROOT}

chrootBuildfs:
	${SC}/chroot.sh ${BUILDFS}
mk_kernel_in_buildfs:
	cp ${SC}/mk-kernel-in-buildfs.sh ${BUILDFS}/home/admin/mk-kernel-in-buildfs.sh
	${SC}/chroot.sh ${BUILDFS} /home/admin/mk-kernel-in-buildfs.sh --userspec=admin:admin

clean:
	rm -rf ./root/*
	
mk_img:
	@echo "TODO"

mountall: umountall
	${SC}/mount.sh

umountall:
	${SC}/umount.sh

mk_SD: partSD cpRootToSD installUBootSD installKernel 

partSD: umountall
	${SC}/part.sh ${SD}
	mkfs.ext4 ${ROOTBD}
	mkfs.vfat ${BOOTBD}

cpRootToSD: mountall
	rsync -avx --delete ${ROOT}/ ${MNTROOT}
	sync

installUBootSD: umountall
	[ -b ${SD} ] || exit 1
	dd if=${BOOT}/sunxi-spl.bin of=${SD} bs=1024 seek=8 

installKernel: mountall
	#mv ${MNTBOOT}"/uImage" ${MNTBOOT}"/uImage.bak" #backup old kernel
	mkimage -C none -A arm -T script -d ${BOOT}/boot.cmd ${BOOT}/boot.scr
	cp ${BOOT}/uImage ${MNTBOOT}/uImage
	cp ${BOOT}/boot.cmd ${MNTBOOT}/
	cp ${BOOT}/boot.scr ${MNTBOOT}/
	cp ${BOOT}/script.bin ${MNTBOOT}/
	chown -R root:root ${BOOT}
	sync

mk_Uboot:
	${SC}/updateU-Boot.sh

mk_Kernel:
	${SC}/updateKernel.sh
help:
	@echo "mk_rootfs	to create an root fs at ${ROOT}"
	@echo "mk_buildfs	to create an build fs " 
	@echo "mountall		mounts boot and root part. to mnt{boot:root}"
	@echo "umountrall	umounts all part. on SD"

