#requiers udev rol to be autoexectuted wehen block device is deteckted

#/bin/bash

DEV="/dev/sda1"

MNT="/home/rbe/mnt"
UPDATEDIR="${MNT}/GN01update"
UPDATETAR="${UPDATEDIR}/GN01update.tar"
UPDATESCRIPT="${UPDATEDIR}/update.sh"

mkdir -p ${MNT}
mount ${DEV} ${MNT}
if [ -e ${UPDATETAR} ]; then
	tar -xf ${UPDATETAR}
	chmod +x ${UPDATESCRIPT}
	./${UPDATESCRIPT}	
fi

umount ${DEV}
