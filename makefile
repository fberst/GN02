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
export PIC=${RES}/picture#		#pictures
export MODULES=${WORK}/modules

export MNTROOT=${WORK}/mnt/root#             	#root mount point
export MNTBOOT=${WORK}/mnt/boot#		#boot mount point

#PATHS to FILS
export IMG=${IMAGE}/gn02.img#

#default pardischen
export BP=p1#   #boot pard
export RP=p2#   #root pard

export MCU=false#	menuconfig uboot
export MCK=false#	menuconfig kernel
export CK=false#	clean kernel src
export CU=false#	clean u-boot
export UPU=false#	update-u-boot


SC=${SCRIPTS}

mk_rootfs:
	${SC}/mk-rootfs.sh

mk_buildfs:
	${SC}/mk-buildfs.sh

mk_Buildfs-x86:
	${SC}/mk-buildfs-x86.sh

chrootL:
	${SC}/chroot.sh ${ROOT}

chrootSD: mountall
	${SC}/chroot.sh ${MNTROOT}

chrootBuildfs:
	${SC}/chroot.sh ${BUILDFS} "/bin/bash --rcfile /home/admin/.bashrc " admin:admin

chrootBuildfs-x86:
	${SC}/chroot-x86.sh ${BUILDFS} "/bin/bash --rcfile /home/admin/.bashrc " admin:admin

mk_kernel_in_buildfs:
	cp ${SC}/mk-kernel-in-buildfs.sh ${BUILDFS}/home/admin/mk-kernel-in-buildfs.sh
	cp ${PIC}/gnBoot_logo_ascii_224.ppm ${BUILDFS}/home/admin/
	${SC}/chroot.sh ${BUILDFS} "/home/admin/mk-kernel-in-buildfs.sh" admin:admin

clean:
	rm -rf ./rootfs/*
	rm -rf ./buildfs/
	
mk_img:
	@echo "TODO"

mountall: umountall
	${SC}/mount.sh

mount_all_old_system: umountall
	${SC}/mount_old_system.sh

umountall:
	${SC}/umount.sh

mk_SD: partSD cpRootfsToSD installUBootSD installKernel install_boot.xxx 

partSD: umountall
	${SC}/part.sh ${SD}
	mkfs.ext3 ${ROOTBD}
	mkfs.vfat ${BOOTBD}

cpRootfsToSD: mountall
	rsync -avx --delete ${ROOT}/ ${MNTROOT}
	sync

install_boot.xxx:
	mkimage -C none -A arm -T script -d ${BOOT}/boot.cmd ${BOOT}/boot.scr
	cp ${BOOT}/boot.cmd ${MNTBOOT}/
	cp ${BOOT}/boot.scr ${MNTBOOT}/

installUBootSD: umountall ${BOOT}/boot.cmd
	[ -b ${SD} ] || exit 1
	dd if=${BOOT}/u-boot-sunxi-with-spl.bin of=${SD} bs=1024 seek=8 

installKernel: mountall
	@#mv ${MNTBOOT}"/uImage" ${MNTBOOT}"/uImage.bak" #backup old kernel
	cp ${BOOT}/uImage ${MNTBOOT}/uImage
	cp ${BOOT}/script.bin ${MNTBOOT}/
	chown -R root:root ${MNTBOOT}/*
	cp -r ${MODULES}/* ${MNTROOT}/
	sync
	${SC}/chroot.sh ${MNTROOT} "depmod -a 3.4.104-gd47d367-dirty "
	sync

mk_Uboot:
	${SC}/updateU-Boot.sh

mk_Kernel:
	${SC}/updateKernel.sh
help:
	@echo "all functions listed hier are tested more ore less"
	@echo "mk_rootfs		to create an root fs at ${ROOT}"
	@echo "mk_buildfs		to create an build fs " 
	@echo "mountall			mounts boot and root part. to mnt{boot:root}"
	@echo "umountrall		umounts all part. on SD" 
	@echo "chrootL			chroot to local rootfs"
	@echo "chrootSD			chroot to ${SD}p2"
	@echo "chrootBuildfs	chroot to buildfs"
	@echo "cpRootfsToSD		self expaining"
	@echo "partSD			parts sdcart"
	@echo ""
