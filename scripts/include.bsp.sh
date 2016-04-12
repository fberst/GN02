#!/bin/bash

##include config and lib's
if [ -e config.sh ]; then
	. config.sh
else
	cd ./scripts/
	if [ -e config.sh ]; then 
		. config.sh
	else
		exit 1
	fi
fi

##exit if root not set 
[ -z ${ROOT} ] && exit 1 

##clean root
rm -r ${ROOT}/*

##clan kernel

##clean foo bar
