#!/bin/bash

# batch process movies in the origin path

PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

ORIGIN="$1"

IFS=$'\n'
for DIR in `ls -1 "${ORIGIN}"`; do
    echo "Manual processing: ${ORIGIN}${DIR}"
    ./auto-process.sh "ID" "${DIR}" "${ORIGIN}"
done
