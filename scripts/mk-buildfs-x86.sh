#!/bin/bash

#VERSION
#SUITE=testing
SUITE=jessie 

cd ${SCRIPTS}

#[ ! -x lib/chroot.sh ] && echo "lib/chroot.sh not found" && exit 1
#. lib/chroot.sh

[ ${UID} != 0 ] && echo "I'm not root" && exit 1
[ -z ${BUILDFS} ] && echo "'$'root not set" exit 1

echo "makeBaseSystem"	

if [ ! -d ${BUILDFS}/usr  ]; then
	mkdir -p ${BUILDFS}
	rm -rf ${BUILDFS}/* #clear $root
	#make new min root 
	sudo debootstrap --verbose --variant=minbase  $SUITE ${BUILDFS}/ http://ftp.debian.org/debian
fi


cp ${SCRIPTS}"/init-buildfs-x86.sh" ${BUILDFS}"/root/init-buildfs.sh"	#cp this script to newRoot
	
#installing fils

#installing sudoers file
if [ -e ${FILES}"/sudoers" ]; then 
	cp ${FILES}"/sudoers" ${BUILDFS}"/etc/sudoers"
	chown root:root ${BUILDFS}"/etc/sudoers"
fi

#install sorces.list
if [ -e ${FILES}"/sources.list" ]; then 
	cp ${FILES}"/sources.list" ${BUILDFS}"/etc/apt/sources.list"
	chown root:root ${BUILDFS}"/etc/apt/sources.list"
fi

#autologin
if [ -e ${FILES}"/autologin.conf" ]; then
	mkdir -p ${BUILDFS}"/etc/systemd/system/getty@tty1.service.d"
	cp -r ${FILES}"/autologin.conf" ${BUILDFS}"/etc/systemd/system/getty@tty1.service.d/autologin.conf"
	[ $? != 0 ] && error "cant install autologin.conf"
fi

./chroot.sh ${BUILDFS} "/root/init-buildfs.sh"  #ecec this script on newRoot
