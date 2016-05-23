#!/bin/bash

#################initGn01#######################

###USERS###

###ADMIN###
userAdmin="admin"               #userName
passAdmin="admin"               #userPw
shellAdmin="/bin/bash"		#shell
groupsAdmin=(
"sudo"   #userGroups
"dialout"
)

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
"libncurses5-dev"
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

#add groups
for group in ${groupsAdmin[@]}; do groupadd -f $group; done
	
#add user to groups
for group in ${groupsAdmin[@]}; do usermod -aG $group $userAdmin; done

exit 0;
