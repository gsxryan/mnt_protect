
# mnt_protect
Monitor mounted Linux folder (iSCSI).

- If it goes down, shutdown connected docker instance.
- If the folder comes back up, restart the connected docker instance.

# Prerequisites
- An operating storagenode container

- crontab -e and add: (storj is the user runas, maybe use root)

- */1 * * * * sudo -u storj -H bash /home/storj/iscsiprotect.sh

- This will check every 1min to make sure the folder is connected.
