#!/bin/bash

#VERSION
#SUITE=testing
SUITE=jessie 
#ARCH
ARCH=armhf

cd ${SCRIPTS}


[ ${UID} != 0 ] && echo "I'm not root" && exit 1
[ -z ${ROOT} ] && echo "'$'root not set" exit 1

echo "makeBaseSystem"	

if [ $CLEARROOT == "true" -o ! -d ${ROOT}/usr  ]; then
	mkdir -p ${ROOT}
	rm -rf ${ROOT}/* #clear $root
	#make new min root 
	sudo debootstrap --verbose --arch $ARCH --variant=minbase --foreign $SUITE ${ROOT}/ http://ftp.debian.org/debian
fi

cp ${SCRIPTS}"/init-rootfs.sh" ${ROOT}"/root/init-rootfs.sh"	#cp this script to newRoot
	
IDEB=root/deb/
#cp .deb to rootfs
mkdir -p ${ROOT}/${IDEB}
if [ -d ${IDEB} ]; then
  for deb in $(ls -1 ${DEB}); do cp ${DEB}/${deb} ${ROOT}/${IDEB}; done
fi

#[ -e ${DEB}/* ] && cp -Rv ${DEB}/* ${ROOT}/$IDEB #cp .deb to root dir

#installing fils

mkdir -p ${ROOT}"/home/rbe/"

#installing sudoers file
if [ -e ${FILES}"/sudoers" ]; then 
	cp ${FILES}"/sudoers" ${ROOT}"/etc/sudoers"
	chown root:root ${ROOT}"/etc/sudoers"
fi

#installintg udev rules
#if [ -e ${FILES}/*".rules" ]; then
	cp ${FILES}/*".rules" ${ROOT}"/lib/udev/rules.d/"
	chown -R root:root ${ROOT}"/lib/udev/rules.d"
#fi

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
if [ -e ${FILES}"/autologin.conf" ]; then
	mkdir -p ${ROOT}"/etc/systemd/system/getty@tty1.service.d"
	cp -r ${FILES}"/autologin.conf" ${ROOT}"/etc/systemd/system/getty@tty1.service.d/autologin.conf"
	[ $? != 0 ] && error "cant install autologin.conf"
fi

#bashrc witch auto exec xcsore 
if [ -e ${FILES}"/bashrc" ]; then
	cp ${FILES}"/bashrc" ${ROOT}"/home/rbe/bashrc"
fi

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

#install GN01-Update.sh
if [ -e ${FILES}"/GN01-Update.sh" ]; then
  cp ${FILES}"/GN01-Update.sh" ${ROOT}"/home/rbe/GN01-Update.sh"
  chmod +x ${ROOT}"/home/rbe/GN01-Update.sh"
fi

#install fstab
cat <<EOT > ${ROOT}/etc/fstab
/dev/mmcblk0p2  /   ext4  defaults  0 1
tmpfs /tmp  tmpfs defaults  0 0
tmpfs /var/tmp  tmpfs defaults  0 0
# if you have a separate boot partition
#/dev/mmcblk0p1	/boot	vfat defaults 0 0 
EOT

./chroot.sh $ROOT "/root/init-rootfs.sh"  #ecec this script on newRoot
