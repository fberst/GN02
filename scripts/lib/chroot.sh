#!/bin/bash

###########################################
#Generic chroot functions
###########################################

. ./config.sh

function chrootMountAll { #mount and cp all staf to chroot
	cp /usr/bin/qemu-arm-static $1"/usr/bin/"
	for i in /dev /dev/pts /proc /sys /run; do mount -B $i $1$i; done 
	mount -o bind /etc/resolv.conf $1"etc/resolv.conf"	
}

function chrootUmountAll { #umount all staf from chroot
	umount $1"etc/resolv.conf"
	for i in /dev/pts /dev /proc /sys /run; do umount $1$i; done

}
	
function chrootExec { #chroot and execute
	info "chrootExec"
	chrootMountAll $1
	chroot $1 $2
	chtootUmountAll $1
	
}

function chrootC { #do all and chroot
	info "chrootC"
	chrootMountAll $1
	chroot $1
	chrootUmountAll $1
}

