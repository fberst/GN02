#!/bin/bash


# have a look at http://linux-sunxi.org/Mainline_U-Boot#Compile_U-Boot

#apt-get install device-tree-compiler


if [ ! -d ${SRCUBOOT}/.git ]; then
  cd ${SRC} 
  git clone git://git.denx.de/u-boot.git
fi

cd ${SRCUBOOT}
git pull
[[ ${CU} == "true" ]] && make clean
[ -f ${SRCUBOOT}/.config ] || make CROSS_COMPILE=arm-linux-gnueabihf- Cubieboard2_defconfig
[[ ${MCU} == "true" ]] make CROSS_COMPILE=arm-linux-gnueabihf- menuconfig
make -j$(nproc) CROSS_COMPILE=arm-linux-gnueabihf- || exit 1

cp ${SRCUBOOT}/u-boot-sunxi-with-spl.bin ${BOOT}/u-boot-sunxi-with-spl.bin
cp ${SRCUBOOT}/.config ${BOOT}/u-boot-config

#dd if=u-boot-sunxi-with-spl.bin of=/dev/sdX bs=1024 seek=8
