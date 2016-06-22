#!/bin/bash

if [ ! -d ${SRCKERNEL}/.git ]; then
  cd ${SRC}
  git clone -b sunxi-3.4 --depth 1 https://github.com/linux-sunxi/linux-sunxi.git || exit 1
fi
cd ${SRCKERNEL}
#git pull

#to cp boot scren to kernel src
#cp ${RES}/picture/gnboot.ppm ${SRCKERNEL}/drivers/video/logo/logo_linux_clut224.ppm

[[ ${CK} == "true" ]] && make clean

[ -f ${SRCKERNEL}/.config ] || make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- sun7i_defconfig
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- menuconfig
make -j$(nproc) ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- uImage modules || exit 1
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- INSTALL_MOD_PATH=output modules_install || exit 1


cd ${WORK}

cp ${SRCKERNEL}/arch/arm/boot/uImage ${BOOT}/
cp ${SRCKERNEL}/.config ${BOOT}/config_curent
cp -r ${SRCKERNEL}/output/* modules/
#arch/arm/boot/uImage		#kernel
#output/lib/modules/3.4.XXX/	#moduls 

