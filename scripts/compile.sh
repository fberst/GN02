#!/bin/bash


#TODO KernelToBoot()
#TODO ModulToRoot()


kernelMenueConfig() { #make menueconfig
	echo "menueConfig"
	cd ${SRCKERNEL}
	make ARCH=arm menuconfig
}

KernelCompile() { #compile kernel
	echo "KernelCompile"
	cd ${SRCKERNEL}
	make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- -j7
}

editScriptBin(){
	TBOOT=$1
	${SCRIPTBIN}"/bin2fex" ${TBOOT}"/script.bin" ${TBOOT}"/script.fex"
	mv ${TBOOT}"/script.bin" ${TBOOT}"/script.bin.bak"
	${DEVAULTEDITOR} ${TBOOT}"/script.fex"
	${SCRIPTBIN}"/fex2bin" ${TBOOT}"/script.fex" ${TBOOT}"/script.bin"
	[ $? != 0 ] && mv ${TBOOT}"/script.bin.bak" ${TBOOT}"/script.bin" && error "error restoring old script.bin"
	rm ${TBOOT}"/script.fex"
	unset TBOOT
}

editScriptBinSD(){
	TDEV=$1
	./mount.sh
	editScriptBin ${MNTBOOT}
	./umount.sh
	unset TDEV	
}
