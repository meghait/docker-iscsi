#!/bin/bash

trap "echo TRAPed signal" HUP INT QUIT KILL TERM

# Mount iscsi-storage.
echo "Restarting iSCSI"
service open-iscsi restart
echo "Discovering and mounting"
iscsiadm  -m discovery -t st -p $1
iscsiadm  -m node  --targetname "$3" --portal "$1:$2" --login
sleep 1
echo "Mounting new iSCSI-device"
mount /dev/disk/by-path/ip-$1:$2-iscsi-$3-lun-0 /mnt/storage

echo "[hit enter key to exit] or run 'docker stop <container>'"
read

# Unmount and log out.
echo "Unmounting iSCSI-mount"
umount /mnt/storage
iscsiadm  -m node  --targetname "$3" --portal "$1:$2" --logout

echo "exited $0"
