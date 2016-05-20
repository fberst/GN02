#!/bin/bash

exit 0

#older 
#git clone https://github.com/linux-sunxi/linux-sunxi/tree/stage/sunxi-3.4

#newer
#git clone https://github.com/linux-sunxi/linux-sunxi/tree/sunxi-next


#make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- sun7i_defconfig

#make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- menuconfig


#make -j$(nproc) ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- uImage modules

#make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- INSTALL_MOD_PATH=output modules_install


#arch/arm/boot/uImage		#kernel
#output/lib/modules/3.4.XXX/	#moduls 

