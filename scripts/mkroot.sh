#!/bin/bash

cd /home/florian/gn02/scripts/

[ ! -x config.sh ] && echo "config not found" && exit 1
. config.sh

[ ${UID} != 0 ] && exit 1
[ -z ${ROOT} ] && exit 1

echo "makeBaseSystem"	
	
if [[ $CLEARROOT == "true" ]]; then
	rm -rf ${ROOT}/* #clear $root
	#make new min root 
	sudo debootstrap --verbose --arch $ARCH --variant=minbase --include=$INC --foreign $SUITE ${ROOT/} http://ftp.debian.org/debian
fi

cp ${BIN}"/initcfg.sh" ${ROOT}"/root/"			#config
cp ${BIN}"/initGn.sh" ${ROOT}"/root/gn01.sh"	#cp this script to newRoot
	
#cp driver staf to root and install mali driver #TODO
	
[ -e ${DEB}/* ] && cp -Rv ${DEB}/* ${ROOT}${IDEB}/ #cp .deb to root dir

#installing fils

#installing sudoers file
if [ -e ${FILES}"/sudoers" ]; then 
	cp ${FILES}"/sudoers" ${ROOT}"/etc/sudoers"
	chown root:root ${ROOT}"/etc/sudoers"
fi

#installintg udev rules
if [ -e ${FILES}/*".rules" ]; then
	cp ${FILES}/*".rules" ${ROOT}"/lib/udev/rules.d/"
	chown -R root:root ${ROOT}"/lib/udev/rules.d"
fi

#install /etc/network/interfaces
if [ -e ${FILES}"/interfaces" ]; then 
	cp ${FILES}"/interfaces" ${ROOT}"/etc/network/interfaces"
	chown root:root ${ROOT}"/etc/network/interfaces"
fi

#install sorces.list
if [ -e ${FILES}"/sources.list" ]; then 
	cp ${FILES}"/sources.list" ${ROOT}"/etc/apt/sources.list"
	chown root:root ${ROOT}"/etc/apt/sources.list"
fi

#autologin
#if [ -e ${FILES}"/autologin.conf" ]; then
#	mkdir -p ${ROOT}"/etc/systemd/system/getty@tty1.service.d 
#	cp -r ${FILES}"/autologin.conf" ${ROOT}"/etc/systemd/system/getty@tty1.service.d/autologin.conf"
#	[ $? != 0 ] && error "cant install autologin.conf"
#fi

#bashrc witch auto exec xcsore 
#if [ -e ${FILES}"/bashrc" ]; then
#	cp ${FILES}"/bashrc" ${ROOT}"/home/rbe/bashrc"
#fi

#installing mali && EGL && GL lib's
if [ -e ${LIB} ]; then 
	cp ${LIB}/* ${ROOT}"/usr/lib/"
	chown -R root:root ${ROOT}"/usr/lib"
fi

# moduls loaded at boot time
rm -f ${ROOT}"/etc/modules"
if [ -e ${FILES}"/modules" ]; then
	cp ${FILES}"/modules" ${ROOT}"/etc/modules"
	chown root:root ${ROOT}"/etc/modules"
fi

#chrootExec $ROOT/ "/root/initGn.sh"  #ecec this script on newRoot
