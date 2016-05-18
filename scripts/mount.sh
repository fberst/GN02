#!/bin/bash

[ ${UID} -eq 0 ] || exit 1

mount ${BOOTBD} ${MNTBOOT} || exit 1
mount ${ROOTBD} ${MNTROOT} || exit 1
