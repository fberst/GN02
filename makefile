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

#PATHS
export MNTROOT=/mnt/root#             	#root mount point
export MNTBOOT=/mnt/boot#		#boot mount point

export WORK=/home/florian/GN02#         #work dir
export IMAGE=${WORK}/image#            	#image dir
export BOOT=${WORK}/boot#               #boot data z.b. uImage ..
export ROOT=${WORK}/root#               #local root dir
export SCRIPTS=${WORK}/scripts#         #bscript's to creat image
export SCRIPTBIN=${SCRIPTS}/scriptBin#  #bin2fex && fex2bin
export SRC=${WORK}/src#                 #sorcecode
export SRCKERNEL=${SRC}/kernel/XXXXX# 	#kernel src #TODO
export SRCUBOOT=${SRC}/uBoot/XXXXX#   	#uBoot src #TODO
export RES=${WORK}/res#                 #resorces
export DEB=${RES}/deb#                  #.deb for auto install 
export FILES=${RES}/files#              #fils to install z.b. sudoers
export LIB=${RES}/lib#                  #mali .so fils z.b. Mali.so, libEGL.so

#PATHS to FILS
export IMG=${IMAGE}/gn01.img#

#default pardischen
export BP=p1#   #boot pard
export RP=p2#   #root pard

SC=${SCRIPTS}

mkroot:
	@echo "mkroot"
	${SC}/mkroot.sh

chrootL:
	@echo "chrootL"
	${SC}/lib/chroot.sh ${ROOT}
chrootSD: mountall
	@echo "chroot SD"
	@echo "TODO"
	exit 0
	${SC}/lib/chroot.sh ${MNTROOT}
mkSD: fdisk
	cptosd ${SD}

clean:
	@rm -rf ./root/*
	
mkimg:
	@echo "TODO"

mountall: umountall
	@echo "TODO"

umountall:
	@echo "umount all"
	${SC}/umount.sh

fdisk: umountall
	@echo fdisk
	${SC}/fDisk.sh ${SD}

cptosd:
	@echo "TODO"

help:
	@echo "TODO"



