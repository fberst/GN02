#!/bin/bash

#################initGn01#######################

###USERS###

###ADMIN###
userAdmin="admin"               #userName
passAdmin="admin"               #userPw
shellAdmin="/bin/bash"		#shell
groupsAdmin[0]="sudo"   #userGroups
groupsAdmin[1]="dialout"

###RBE###
userRbe="rbe"                   #userName, xcsor user
passRbe="rbe"                   #userPw
shellRbe="/bin/bash"		#shell
groupsRbe[0]="sudo"             #userGroups
groupsRbe[1]="video"
groupsRbe[2]="dialout"  #rs232
groupsRbe[3]="mali"             #gpu
groupsRbe[4]="mice"             #mice
groupsRbe[5]="ump"              #
groupsRbe[6]="netdev"   #net

###PACKETEStoINSTALL###
PLIST=(
"apt-utils"
"rsync"
"firmware-linux-nonfree"
#"libcurl3"              #xcsore-dep
#"libjpeg8"              #...
#"libpng12-0"            #...
#"ttf-dejavu"            #...
#"stow"                   #...
"locales"
"ssh"
"htop"
"console-common"
"udev"
"netbase"
"ifupdown"
"isc-dhcp-client"
#"resolvconf"
"sudo"
"systemd"
"systemd-sysv"
"vim"
"net-tools"
"bash-completion"
"locales"
"gcc"
"dialog"
"sunxi-tools"
"tar"
"gzip"
"u-boot-tools"
"make"
"g++"

)



###INITPATHS###
IDEB="/root/deb"

CLEANUP="false" #clean up image
##################initGn01#END####################

echo "initBaseSystem"

#initBaseSystem
[ -x "/debootstrap/debootstrap" ] && /debootstrap/debootstrap --second-stage

##system einrichten und so 	
apt-get update
apt-get upgrade -y
apt-get dist-upgrade -y					#update all
#apt-get install -y  $P				#install packetses

for i in ${PLIST[@]}; do echo "INSTALL: $i"; apt-get install -y $i; done

if [ -e ${IDEB} ]; then
	dpkg --install ${IDEB}/*.deb
	[ $? -ne 0 ] && echo "dpkg error $?" exit 1
fi

#seting up user admin
useradd --create-home --user-group -s ${shellAdmin} --password $passAdmin $userAdmin 
#seting up user rbe
useradd --create-home --user-group -s ${shellRbe} --password $passRbe $userRbe

#add groups
for group in ${groupsAdmin[@]}; do groupadd -f $group; done
for group in ${groupsRbe[@]}; do groupadd -f $group; done
	
#add user to groups
for group in ${groupsAdmin[@]}; do usermod -aG $group $userAdmin; done
for group in ${groupsRbe[@]}; do usermod -aG $group $userRbe; done

[ -f "/home/rbe/bashrc" ] && mv "/home/rbe/bashrc" "/home/rbe/.bashrc"
[ $? -eq 1 ] && echo "can't install .bashrc"
[ -f "/home/rbe/.bashrc" ] && chown rbe:rbe "/home/rbe/.bashrc"

#sherd lib setup #TODO
ldconfig		
#xcsore staf	#TODO


if [ ${CLEANUP} == "true" ]; then
	rm -rf ${IDEB} #rm deb dir
	rm -f /root/initGn.sh
fi

exit 0;
