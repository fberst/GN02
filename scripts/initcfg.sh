#!/bin/bash

#################initGn01#######################

###USERS###

###ADMIN###
userAdmin="admin"		#userName
passAdmin="admin"		#userPw
groupsAdmin[0]="sudo"	#userGroups
groupsAdmin[1]="dialout"

###RBE###
userRbe="rbe"			#userName, xcsor user
passRbe="rbe"			#userPw
groupsRbe[0]="sudo"		#userGroups
groupsRbe[1]="video"
groupsRbe[2]="dialout"	#rs232
groupsRbe[3]="mali"		#gpu
groupsRbe[4]="mice"		#mice
groupsRbe[5]="ump"		#
groupsRbe[6]="netdev"	#net


###PACKETEStoINSTALL###
PACKLIST=rsync
PACKLIST+=,firmware-linux-nonfree
PACKLIST+=,libcurl3					#xcsore-dep
PACKLIST+=,libjpeg8					#...
PACKLIST+=,libpng12-0 				#...
PACKLIST+=,ttf-dejavu				#...
PACKLIST+=,stow						#...
#PACKLIST+=,bar

###INITPATHS###
IDEB="/root/deb"

CLEANUP="false" #clean up image
##################initGn01#END####################
