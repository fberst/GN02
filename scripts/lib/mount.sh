#!/bin/bash

#############################
#Generic mount functions
############################

RED='tput setaf 1'		#RED
errorExit() { #print red text and exit 
	echo "$($RED)$2$($NC)"
	#exit $1
}


RMP="false" #no rm mount point

umountDev() { #laufwerke aushängen 
	TUDEV=$1
	TUMNT=$2
	[ ! -b ${TUDEV} ] && errorExit 1 "dev not found"
	#eingehängte laufwerke aushängen
	if [[ $(mount) == *"${TUDEV}"* ]]; then 
		echo "umount ${TUDEV} ${TUMNT}"
		umount ${TUDEV} 
		#Auf mount Fehler testten
		[ $? -ne 0 ] && errorExit 1 "umount ERROR $?"
	fi
	#rm mount point
	[ ${TUMNT} != "NULL" -a $RMP == "true" ] && rm -r ${TUMNT}
	unset TUDEV
	unset TUMNT
}

mountDev() { #laufwerke einhängen
	TMDEV=$1
	TMMNT=$2
	
	echo "mount ${TMDEV} ${TMMNT}"

	[ ! -b ${TMDEV} ] && errorExit 1 "dev not found"
	if [ ! -e ${TMMNT} ]; then #mount punkt erstellen
		mkdir ${TMMNT} 
		echo "mkdir ${TMMNT}"
	fi
	umountDev ${TMDEV} "NULL"
	mount ${TMDEV} ${TMMNT} #mounten
	#Auf mount Fehler testten
	[ $? -ne 0 ] && errorExit 1 "mount ERROR $?"
	unset TMDEV
	unset TMMNT
}
