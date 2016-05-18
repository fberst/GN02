#!/bin/bash


# have a look at http://linux-sunxi.org/Mainline_U-Boot#Compile_U-Boot

#apt-get install device-tree-compiler


#git clone git://git.denx.de/u-boot.git

make clean

make CROSS_COMPILE=arm-linux-gnueabihf- Cubieboard2_defconfig

make CROSS_COMPILE=arm-linux-gnueabihf- menuconfig

make CROSS_COMPILE=arm-linux-gnueabihf-


 mkimage -C none -A arm -T script -d boot.cmd boot.scr

dd if=u-boot-sunxi-with-spl.bin of=/dev/sdX bs=1024 seek=8
