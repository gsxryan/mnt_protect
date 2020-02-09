#!/bin/sh

#Check iSCSI network status
#If iSCSI/mounted folder is down, shutdown any connected nodes
#Resume when the folder has restored
#GSXRyan github, Kernelpanick Storj.io

#Environment Variables to Edit:
MNT_Path="/mnt/iscsi/StorjV3/config.yaml"
Log_Path="/home/user/SCSIWatch.log"

TODAY=$(date '+%D %H:%M:%S')
echo "$TODAY Script is running" >> $Log_Path

#Check node status
NODE=$(docker inspect -f '{{.State.Running}}' storagenode)
#echo "Node Status = $NODE" >> $Log_Path

#Check folder Status
if test -f "$MNT_Path"; then
    iSCSI="UP"
fi

#If node is up, and Folder is down, stop the node
if [ -z "$iSCSI" ]; then
#    echo "FOLDER DOWN" >> $Log_Path
    if [ $NODE == "true" ]; then
#      echo "NODE UP" >> $Log_Path
#Log the Stop
      echo "$TODAY NODE STOPPED: The node was stopped because the folder is inaccessable" >> $Log_Path
#Stop the node
docker stop -t 300 storagenode
#else echo "NODE DOWN catch" >> $Log_Path
fi
fi

#If node is down, and folder is up, start the node 
if [ -n "$iSCSI" ]; then
#    echo "FOLDER UP" >> $Log_Path
    if [ $NODE == "false" ]; then
#      echo "NODE DOWN" >> $Log_Path
#Log the Start
echo "$TODAY NODE STARTED: The node was started because the folder is accessable again" >> $Log_Path
#Start the Node
docker start storagenode
else echo "NODE and Folder is UP, sleeping..." >> $Log_Path
fi
fi
