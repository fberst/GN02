#!/bin/bash

[ ${UID} -eq 0 ] || exit 1

mkdir -p ${MNTROOT} ${MNTBOOT}

mount ${SD}p1 ${MNTROOT} || exit 1
mount --bind ${MNTROOT}/boot ${MNTBOOT}
