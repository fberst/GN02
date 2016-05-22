#!/bin/bash

if [ ! -d ${SRCKERNEL}/.git ]; then
  cd ${SRC}
  git clone -b sunxi-3.4 https://github.com/linux-sunxi/linux-sunxi.git
fi
cd ${SRCKERNEL}
git pull
echo "#include <linux/compiler-gcc4.h>" > ${SRCKERNEL}/include/linux/compiler-gcc5.h

exit 0
#to cp boot scren to kernel src
#cp ${RES}/picture/gnboot.ppm ${SRCKERNEL}/drivers/video/logo/logo_linux_clut224.ppm
make clean
[ -f ${SRCKERNEL}/.config ] || make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- sun7i_defconfig
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- menuconfig
make -j$(nproc) ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- uImage modules
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- INSTALL_MOD_PATH=output modules_install

#arch/arm/boot/uImage		#kernel
#output/lib/modules/3.4.XXX/	#moduls 

