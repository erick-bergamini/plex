#!/bin/bash
#### post-process after filebot do its job
#### this scripts executes after filebot renames
#### https://github.com/allangarcia/seedbox-to-plex-automation

PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

# Input variables
FILE="$1"
FOLDER="$2"

# If this is a movie try to download the trailers
/opt/scripts/download-trailers.sh "${FOLDER}"

# This should be last
# Setting up the right permissions for plex
chown -R plex: "${FOLDER}"
find "${FOLDER}" -type f -exec chmod 664 {} \;
find "${FOLDER}" -type d -exec chmod 775 {} \;
chmod 775 "${FOLDER}"
chmod 664 "${FILE}"
