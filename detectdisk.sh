#!/bin/bash

export $ID_FS_LABEL

{
  date >> /var/log/autorip.log
  if [ `who | wc -l` -gt 0 ] 
    then
       echo "User logged in. Aborting ..." >> /var/log/autorip.log
    else
 	 if [ $ID_CDROM_MEDIA -eq 1 ]; then
		echo "Disk detected, starting autorip.sh" >> /var/log/autorip.log
		/usr/local/bin/autorip.sh &	
  	else
		echo "No Disk detected" >> /var/log/autorip.log
  	fi
    fi

}
