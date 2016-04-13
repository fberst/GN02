#!/bin/bash

#debootstrap include
INC=locales
INC+=,ssh
INC+=,htop
INC+=,console-common
INC+=,udev
INC+=,netbase
INC+=,ifupdown
INC+=,isc-dhcp-client
INC+=,resolvconf
INC+=,sudo
INC+=,systemd
INC+=,systemd-sysv
INC+=,vim
INC+=,net-tools

#VERSION
#SUITE=testing
SUITE=jessie

###ARCH###
ARCH=armhf

