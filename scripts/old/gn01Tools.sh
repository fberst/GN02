#!/bin/bash

#############################################################
#GN01 build script 
#frassl@gmx.de
#############################################################

#############################################################
#on horst system
#is not complite
#apt-get install qemu-user-static, 
#
#############################################################

exit 1 #dont use 

[ -x ./lib/chroot.sh ] && . ./lib/chroot.sh	#include chrootFunctions
[ $? != 0 ] && echo "error" && exit 1
[ -x ./lib/mount.sh ] && . ./lib/mount.sh 	#include mount.sh
[ $? != 0 ] && echo "error" && exit 1


testRoot() { #test for root prefilegs
	[ $UID != 0 ] && echo "ERROR no root prefilegs!" && exit 1
}


parsPar() { # pars parameter 
	echo "$($GREEN)GN01 script$($NC)"
	export DDEV=${DEFAULTDEV}
	#set dev
	for i in $*; do
		if [[ $i == *"/dev/"* ]]; then
			export DDEV=$i
			testDev ${DEV}
			break
		fi
	done
	#set .img
	for i in $*; do
		if [[ $i == *".img" ]]; then
			testRoot
			export DDEV=$(losetup -P -f --show $i)
			export BP=p1	
			export RP=p2
			break
		fi
	done
	#set root
	for i in $*
	do
		if [[ $trd == "1" ]]; then
			ROOT=$i
			break
		fi	
		if [[ $i == *"-rs"* ]]; then
			echo "**********************"
			trd=1
		fi
	done
	unset trd
	#set root partishen
	for i in $*
	do
		if [[ $trd == "1" ]]; then
			rp=$i
			break
		fi	
		if [[ $i == *"-rp"* ]]; then
			echo "**********************"
			trd=1
		fi
	done

	debug "dev=${DDEV}"
	
	noOpt="true"
	if [[ $* == *"-h"* ]]; then #help
		printHelp
		noOpt="false"
	fi
	if [[ $* == *"-fd"* ]]; then #format
		testDev ${DDEV}
		testRoot
		formatSD ${DDEV}
		noOpt="false"
	fi
	if [[ $* == "-cm" ]]; then #menueconfig
		kernelMenueConfig	
		noOpt="false"
	fi
	if [[ $* == *"-cs"* ]]; then #copy to SD
		testDev ${DDEV}
		testRoot
		copyToSD ${DDEV}$mp
		noOpt="false"
	fi
	if [[ $* == *"-ms"* ]]; then #makeSD
		testDev ${DDEV}
		testRoot
		makeSD ${DDEV}
	fi
	if [[ $* == *"-mi"* ]]; then #make image
		testRoot
		makeImage
		noOpt="false"
	fi
	if [[ $* == *"-csd"* ]]; then #chroot sd
		testDev ${DDEV}
		testRoot
		info "chrootSD"
		mountDev ${DDEV}${RP} ${MNTROOT}
		chrootC ${MNTROOT}
		umountDev ${DDEV}${RP} ${MNTROOT}
		noOpt="false"
	fi
	if [[ $* == *"-cl"* ]]; then #chroot local
		info "chroot local"
		testRoot
		chrootC ${ROOT}
		noOpt="false"
	fi
	if [[ $* == *"-ma"* ]]; then #mount all 
		info "mount all"
		testDev ${DDEV}
		testRoot
		mountDev ${DDEV}${BP} ${MNTBOOT}
		mountDev ${DDEV}${RP} ${MNTROOT}
		noOpt="false"
	fi
	if [[ $* == *"-ua"* ]]; then #umount all
		info "umount all"
		testDev ${DDEV}
		testRoot
		umountDev ${DDEV}${BP} ${MNTBOOT}
		umountDev ${DDEV}${RP} ${MNTROOT}
		noOpt="false"
	fi
	if [[ $* == *"-mdi"* ]]; then #mount default .img
		echo TODO #TODO
	fi	
	if [[ $* == *"-mr"* ]]; then #make root
		testRoot
		makeBaseRoot
		noOpt="false"
	fi
	if [[ "$noOpt" == "true" ]]; then #print help
		printHelp
	fi
}

#########main########
#clean loop's
for loop in $(ls /dev/loop?); do
	[ -e ${loop}p1 ] && losetup "-d" $loop
done

parsPar $*
exit 0
