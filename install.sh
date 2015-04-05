#!/bin/sh
LOCALBIN=/usr/local/bin

install -m 644 autodvd.rules /etc/udev/rules.d/
install -m 774 detectdisk.sh $LOCALBIN 
install -m 774 autorip.sh $LOCALBIN

udevadm control --reload-rules
