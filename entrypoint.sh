#!/bin/bash

if [ ! -d "/backup" ]; then
    echo "Error: You must mount a volume to /backup."
    exit 1
fi

if [ ! -f "/restic.conf" ]; then
    echo "Error: You must mount file /restic.conf"
    exit 1
fi
 
if [ ! -f "/root/.config/rclone/rclone.conf" ]; then
    echo "Error: You must mount file /root/.config/rclone/rclone.conf"
    exit 1
fi

# check if directory is empty
if [ "$(ls -A /backup)" ]; then
    echo "Error: /backup is not empty."
    exit 1
fi

if [ -z "$RESTIC_REPO" ]; then
    echo "Error: RESTIC_REPO environment variable is not set."
    exit 1
fi

# Restore the backup to /backup
echo "running restic restore"
restic --repo $RESTIC_REPO --password-file /restic.conf restore latest --target /backup

echo "Restore complete!"
