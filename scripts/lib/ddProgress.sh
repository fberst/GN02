#!/bin/bash

ddProgress() { #dd witch progress use: ddProgress opts
	dd $* &
	DDPID=$!
	while true; do
		clear
		kill -USR1 ${DDPID}
		echo "DD PID=${DDPID}"
		echo "don't interrupt!! type \"sudo kill ${DDPID}\" to kill dd"
		sleep 1
	done 
	unset DDPID
}
