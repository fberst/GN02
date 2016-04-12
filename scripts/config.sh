#1/bin/bash

######################################
#GN01 image config
#
######################################
##DEFAULTS
DEFAULTDEV=/dev/mmcblk0	#default dev
DEFAULTEDITOR=vim		#default editor

CLEARROOT="false" #clear root when making new $root " -mr "

#PATHS
MNTROOT="/mnt/root"		#root mount point
MNTBOOT="/mnt/boot"		#boot mount point

WORK="/home/florian/gn02"	#work dir
IMAGE=${WORK}"/image"		#image dir
BIN=${WORK}"/bin"			#bin's and scripts
SCRIPTS=${WORK}"/scripts"
SCRIPTBIN=$BIN"/scriptBin"	#bin2fex && fex2bin
BOOT=${WORK}"/boot"			#boot data z.b. uImage ..
ROOT=${WORK}"/root"			#local root dir
BIN=${WORK}"/bin"			#bin's & script's to creat image
SRC=${WORK}"/src"			#sorcecode
SRCKERNEL=${SRC}"/kernel/XXXXX"	#kernel src #TODO
SRCUBOOT=${SRC}"/uBoot/XXXXX"	#uBoot src #TODO
RES=${WORK}"/res"			#resorces
DEB=${RES}"/deb"			#.deb for auto install 
FILES=${RES}"/files"			#fils to install z.b. sudoers
LIB=${RES}"/lib"			#mali .so fils z.b. Mali.so, libEGL.so

#PATHS to FILS
IMG=${IMAGE}"/gn01.img"

#default pardischen leiout
BP=p1	#boot pard
RP=p2	#root pard


####################DEBOOTSTRAP#################
#debootstrap include
INC=locales
INC+=,ssh
INC+=,htop
INC+=,console-common
INC+=,udev
INC+=,netbase
INC+=,ifupdown
INC+=,isc-dhcp-client
INC+=,resolvconf
INC+=,sudo
INC+=,systemd
INC+=,systemd-sysv
INC+=,vim
INC+=,net-tools

#VERSION
#SUITE=testing
SUITE=jessie

###ARCH###
ARCH=armhf
#################DEBOOTSTRAP#END################
##################CONFIG#END######################

##################COLOROUTPUT#####################
NC='tput sgr0'			#NO COLOR
RED='tput setaf 1'		#RED
GREEN='tput setaf 2'	#GREEN
BLUE='tput setaf 4'		#BLUE

info() { #print green text
	echo "$($GREEN)$*$($NC)"
}

debug() { #prints green text
	echo "$($BLUE)$*$($NC)"
}

error() { #print red text 
	echo "$($RED)$*$($NC)"
}

errorExit() {
	error $2
	exit $1
}

################COLOROUTPUT#END###################
