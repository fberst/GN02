#!/bin/bash

#################initGn01#######################

###USERS###

###ADMIN###
userAdmin="admin"               #userName
passAdmin="admin"               #userPw
groupsAdmin[0]="sudo"   #userGroups
groupsAdmin[1]="dialout"

###RBE###
userRbe="rbe"                   #userName, xcsor user
passRbe="rbe"                   #userPw
groupsRbe[0]="sudo"             #userGroups
groupsRbe[1]="video"
groupsRbe[2]="dialout"  #rs232
groupsRbe[3]="mali"             #gpu
groupsRbe[4]="mice"             #mice
groupsRbe[5]="ump"              #
groupsRbe[6]="netdev"   #net


###PACKETEStoINSTALL###
P="rsync "
P+="firmware-linux-nonfree "
#P+="libcurl3 "              #xcsore-dep
#P+="libjpeg8 "              #...
#P+="libpng12-0 "              #...
#P+="ttf-dejavu "              #...
P+="stow "                    #...
P+="locales "
P+="ssh "
P+="htop "
P+="console-common "
P+="udev "
P+="netbase "
P+="ifupdown "
P+="isc-dhcp-client "
#P+="resolvconf "
P+="sudo "
P+="systemd "
P+="systemd-sysv "
P+="vim "
P+="net-tools "


###INITPATHS###
IDEB="/root/deb"

CLEANUP="false" #clean up image
##################initGn01#END####################

echo "initBaseSystem"

#initBaseSystem
echo "debootstrap"
[ -x "/debootstrap/debootstrap" ] && /debootstrap/debootstrap --second-stage

##system einrichten und so 	
apt-get update
apt-get upgrade -y
apt-get dist-upgrade -y					#update all
#apt-get install -y  $P				#install packetses

for i in ${P}; do apt-get install -y $i; done

if [ -e ${IDEB} ]; then
	dpkg --install ${IDEB}/*.deb
	[ $? -ne 0 ] && echo "dpkg error $?" exit 1
fi

#seting up user admin
useradd --create-home --user-group --password $passAdmin $userAdmin 
#seting up user rbe
useradd --create-home --user-group --password $passRbe $userRbe

#add groups
for group in ${groupsAdmin[@]}; do groupadd $group; done
for group in ${groupsRbe[@]}; do groupadd $group; done
	
#add user to groups
for group in ${groupsAdmin[@]}; do usermod -aG $group $userAdmin; done
for group in ${groupsRbe[@]}; do usermod -aG $group $userRbe; done

[ -x "/home/rbe/bashrc" ] && mv "/home/rbe/bashrc" "/home/rbe/.bashrc"
[ $? -eq 1 ] && echo "can't install .bashrc"
[ -x "/home/rbe/.bashrc" ] && chown rbe:rbe "/home/rbe/.bashrc"

#sherd lib setup #TODO
ldconfig		
#xcsore staf	#TODO


if [ ${CLEANUP} == "true" ]; then
	rm -rf ${IDEB} #rm deb dir
	rm -f /root/initGn.sh
fi

exit 0; 	
