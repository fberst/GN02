#!/bin/bash

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
