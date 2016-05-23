#!/bin/bash

CLEAN=0
MCONF=0

SRCK="linux-sunxi"

cd "/home/admin/" || exit 1

if [ ! -d ${SRCK}/.git ]; then
  git clone -b sunxi-3.4 --depth 1 https://github.com/linux-sunxi/linux-sunxi.git || exit 1
fi

cp gnBoot_logo_ascii_224.ppm ./linux-sunxi/drivers/video/logo/logo_linux_clut224.ppm
cd ${SRCK}
git pull

#to cp boot scren to kernel src
#cp ${RES}/picture/gnboot.ppm ${SRCKERNEL}/drivers/video/logo/logo_linux_clut224.ppm


[ $CLEAN -eq 1 ] && make clean

[ -f ${SRCK}/.config ] || make  sun7i_defconfig
[ $MCONF -eq 1 ] && make  menuconfig
make -j$(nproc) ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- uImage modules || exit 1
make INSTALL_MOD_PATH=output modules_install

#arch/arm/boot/uImage		#kernel
#output/lib/modules/3.4.XXX/	#moduls 

