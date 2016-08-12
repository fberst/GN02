#!/bin/bash

#################initGn01#######################

###hostName###
HOSTNAME="GN02"

###USERS###

###root####
passRoot="GN02"

###ADMIN###
userAdmin="admin"               #userName
passAdmin="admin"               #userPw
shellAdmin="/bin/bash"		#shell
groupsAdmin=(
"sudo"   #userGroups
"dialout"
)

###RBE###
userRbe="rbe"                   #userName, xcsor user
passRbe="rbe"                   #userPw
shellRbe="/bin/bash"		#shell
groupsRbe=(
"sudo"             #userGroups
"video"
"dialout"  #rs232
"mali"             #gpu
"mice"             #mice
"ump"              #
"netdev"   #net
)

###PACKETEStoINSTALL###
PLIST=(
"apt-utils"
"rsync"
"firmware-linux-nonfree"
"htop"
"kbd"
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
#"gcc"
#"sunxi-tools"
"tar"
"gzip"
"wget"
#"u-boot-tools"
"make"
#"g++"
#"libncurses5-dev"
"openssl"
"kmod"
#xcsoar deb's
"libcurl3"
"libfreetype6"
"libjpeg62-turbo"
"libpng12-0"
"ttf-dejavu"
"libtiff5"
"libgeotiff2"
"libinput5"
"lua5.2"
"liblua5.2"
"libasound2"
)

CLEANUP="false" #clean up image
##################initGn01#END####################

echo "initBaseSystem"

#initBaseSystem
[ -x "/debootstrap/debootstrap" ] && /debootstrap/debootstrap --second-stage

export LANG=en_US.UTF-8
##update 	
apt-get update
apt-get upgrade -y
apt-get dist-upgrade -y	

#update and istall locales
apt-get install -y dialog locales 
echo "reconfigur locals? [y/n]"
read rin
[ ${rin} == "y" -o ${rin} == "Y" ] && dpkg-reconfigure locales

#install all package
for i in ${PLIST[@]}; do echo "INSTALL: $i"; apt-get install -y $i; done

#install all .deb
IDEB="/root/deb"
if [ -e ${IDEB} ]; then
  for i in $(ls -1 ${IDEB}/); do
    dpkg --install ${IDEB}/*.deb
    [ $? -ne 0 ] && echo "dpkg error $?" exit 1
  done
fi

#seting pw for root
usermod -p $(openssl passwd ${passRoot}) root

#seting up user admin
useradd --create-home --user-group -s ${shellAdmin} -p $(openssl passwd ${passAdmin}) ${userAdmin} 

#seting up user rbe
useradd --create-home --user-group -s ${shellRbe} -p $(openssl passwd ${passRbe}) ${userRbe}

#add groups
for group in ${groupsAdmin[@]}; do groupadd -f $group; done
for group in ${groupsRbe[@]}; do groupadd -f $group; done
	
#add user to groups
for group in ${groupsAdmin[@]}; do usermod -aG ${group} ${userAdmin}; done
for group in ${groupsRbe[@]}; do usermod -aG ${group} ${userRbe}; done

#finaly install bashrc with auto start xcsore 
[ -f "/home/rbe/bashrc" ] && mv "/home/rbe/bashrc" "/home/rbe/.bashrc"
[ $? -eq 1 ] && echo "can't install .bashrc"
[ -f "/home/rbe/.bashrc" ] && chown ${userRbe}:${userRbe} "/home/rbe/.bashrc"

#This is my homedir. There are many like it, but this one is mine. My homedir is my best friend. It is my life. I must master it as I master my life. My homedir, without me, is useless. Without my homedir, I am useless.
chown -R ${userRbe}:${userRbe} /home/${userRbe}

#configure dynamic linker run-time bindings
ldconfig		

#set hostname
echo ${HOSTNAME} > "/etc/hostname"

if [ ${CLEANUP} == "true" ]; then
	rm -rf ${IDEB} #rm deb dir
	rm -f /root/init-rootfs.sh
fi

exit 0;
