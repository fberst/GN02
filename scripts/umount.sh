#!/bin/bash

for d in $(ls -1 ${SD}p*); do 
  if [ -n "$(findmnt --source $d)" ]; then
    echo "umount $d" 
    umount $d || exit $?
  fi
done
exit 0
