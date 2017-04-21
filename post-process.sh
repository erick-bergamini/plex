#!/bin/bash
#### post-process after filebot do its job
#### this script executes after filebot renames on the destination folder
#### https://github.com/allangarcia/seedbox-to-plex-automation

PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
[ -r /etc/environment ] && . /etc/environment

# Input variables
FILE="$1"
FOLDER="$2"

# If this is a movie try to download the trailers
/opt/scripts/download-trailers.sh "${FOLDER}"

# This should be last
# Setting up the right permissions for plex
chown -R plex: "${FOLDER}"
find "${FOLDER}" -type f -exec chmod 666 {} \;
find "${FOLDER}" -type d -exec chmod 777 {} \;
chmod 777 "${FOLDER}"
chmod 666 "${FILE}"
