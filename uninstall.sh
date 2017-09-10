#!/bin/sh
LOCALBIN=/usr/local/bin

rm -v /etc/udev/rules.d/autodvd.rules
rm -v $LOCALBIN/detectdisk.sh 
rm -v $LOCALBIN/autorip.sh

udevadm control --reload-rules
