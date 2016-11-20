#!/bin/bash


if [ ! -d ${SRCKERNEL}/.git ]; then
  cd ${SRC}
  git clone -b sunxi-3.4 --depth 1 https://github.com/linux-sunxi/linux-sunxi.git || exit 1
  cd ${SRCKERNEL}
  cp ${RES}/compiler-gcc5.h ${SRCKERNEL}/include/linux/
  cp ${RES}/compiler-gcc6.h ${SRCKERNEL}/include/linux/
  patch -p1 < ${RES}/0001-gcc5.patch
fi

cd ${SRCKERNEL}

if [[ ${DISPLAY_ZOLL} == 5 ]]; then
  [ -e ${PIC}/gn_boot_5zoll.bmp ] && bmptoppm ${PIC}/gn_boot_5zoll.bmp > ${PIC}/gn_boot.ppm 
else
  [ -e ${PIC}/gn_boot.bmp ] && bmptoppm ${PIC}/gn_boot.bmp > ${PIC}/gn_boot.ppm
fi

if [ ! -e ${PIC}/gn_boot.ppm ]; then
  echo "NO BOOT LOGO FOUND"
  exit 1
fi
ppmquant 224 ${PIC}/gn_boot.ppm > ${PIC}/gn_boot_logo_224.ppm
pnmnoraw ${PIC}/gn_boot_logo_224.ppm > ${PIC}/gn_boot_logo_ascii_224.ppm || exit 1

cp ${PIC}/gn_boot_logo_ascii_224.ppm ${SRCKERNEL}/drivers/video/logo/logo_linux_clut224.ppm

[ ! -e ${SRCKERNEL}/.config ] && cp ${BOOT}/config_current ${SRCKERNEL}/.config

[[ ${CK} == "true" ]] && make clean

[ -f ${SRCKERNEL}/.config ] || make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- sun7i_defconfig
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- menuconfig
make -j$(nproc) ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- uImage modules || exit 1
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- INSTALL_MOD_PATH=output modules_install || exit 1


cd ${WORK}

if [[ ${DISPLAY_ZOLL} == 5 ]]; then
  cp ${SRCKERNEL}/arch/arm/boot/uImage ${BOOT}/uImage_5zoll
else
  cp ${SRCKERNEL}/arch/arm/boot/uImage ${BOOT}/5zoll_uImage
fi
cp ${SRCKERNEL}/.config ${BOOT}/config_current
cp -r ${SRCKERNEL}/output/* modules/

#arch/arm/boot/uImage		#kernel
#output/lib/modules/3.4.XXX/	#moduls 

