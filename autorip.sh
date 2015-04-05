#/bin/sh

## variables

# optical drive:
DISK=/dev/sr0
# mount point for media disk
MPT=/media/cdrom
TMP=/var/tmp
LOG=/var/log/autorip.log
RIPIT=ripit
MEDIAROOT=/media/efca31ef-f707-404d-a0ea-fe1981866aa4/Medien
MUSIC=$MEDIAROOT/Musik/
MOVIES=$MEDIAROOT/Spielfilme/
DATA=$MEDIAROOT/Imports/
RIPITOPTS="--nointeraction -c 1 -o $MUSIC"
DVDBACKUP=dvdbackup
DVDBACKUPOPTS="-p -M -o $TMP -n $ID_FS_LABEL"
HANDBRAKE=HandBrakeCLI
HANDBRAKEOPTS="-i $TMP/$ID_FS_LABEL/VIDEO_TS --main-feature -o $MOVIES/$ID_FS_LABEL.mkv -f mkv -e x264 -q 20 -E faac -N deu --native-dub"

## determine type of disk

if disktype $DISK | grep -q "Audio track" 
then
	TYPE=audio
	echo "it's an audio disk!" >> $LOG
	$RIPIT $RIPITOPTS >> $LOG 2>&1
	eject

elif disktype $DISK | grep -q "Data track"
then
	sudo mount $DISK $MPT
	if ls $MPT | grep -q VIDEO_TS
	then
		TYPE=video
		echo "it's a video DVD!" >> $LOG
		umount $DISK
		$DVDBACKUP $DVDBACKUPOPTS >> $LOG
		eject		
		$HANDBRAKE $HANDBRAKEOPTS >> $LOG &
		echo "HandBrake started" >> $LOG
	else
		TYPE=data
		echo "it seems to be some data disk :-/" >> $LOG
		umount $DISK
		dd if=/dev/sr0 of=$DATA/$ID_FS_LABEL.iso
		eject
	fi
fi

date >> $LOG
echo "autorip.sh exited" >> $LOG
echo "-+-+-+-+-+-+-+-+-+-" >> $LOG
