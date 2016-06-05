#!/bin/bash

[ ${UID} -eq 0 ] || exit 1

mkdir -p ${MNTROOT}

mount ${SD}p1 ${MNTROOT} || exit 1
