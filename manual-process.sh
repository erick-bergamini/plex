#!/bin/bash
#### manual-process
#### this script executes the auto-process on a given path
#### https://github.com/allangarcia/seedbox-to-plex-automation

PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
[ -r /etc/environment ] && . /etc/environment

# Input variables
ORIGIN="$1"

# batch process movies in the origin path
IFS=$'\n'
for DIR in `ls -1 "${ORIGIN}"`; do
    echo "Manual processing: ${ORIGIN}${DIR}"
    ./auto-process.sh "ID" "${DIR}" "${ORIGIN}"
done
