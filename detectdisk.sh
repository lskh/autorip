#!/bin/bash

export $ID_FS_LABEL

{
  date >> /var/log/autorip.log
  if [ $ID_CDROM_MEDIA -eq 1 ]; then
	echo "Disk detected, starting autorip.sh" >> /var/log/autorip.log
	/usr/local/bin/autorip.sh &	
  else
	echo "No Disk detected" >> /var/log/autorip.log
  fi

}
