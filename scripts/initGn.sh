#!/bin/bash

##include config and lib's
if [ -e config.sh ]; then
	. initcfg.sh
else
	cd ./scripts/
	if [ -e initcfg.sh ]; then 
		. initcfg.sh
	else
		exit 1
	fi
fi



. ./initcfg.sh

echo "initBaseSystem"

#initBaseSystem
[ -x "/debootstrap/debootstrap" ] && /debootstrap/debootstrap --second-stage

##system einrichten und so 	
apt-get update
apt-get upgrade
apt-get dist-upgrade					#update all
apt-get install $PACKLIST				#install packetses

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
	rm -f /root/config.sh root/initGn.sh
fi

exit 0; 	
