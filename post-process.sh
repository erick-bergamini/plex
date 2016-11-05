#!/bin/bash

PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

FILE="$1"
FOLDER="$2"

# Change permissions

chown -R plex: "${FOLDER}"
find "${FOLDER}" -type f -exec chmod 664 {} \;
find "${FOLDER}" -type d -exec chmod 775 {} \;
chmod 775 "${FOLDER}"
chmod 664 "${FILE}"

# If this is a movie try to download the trailers

/opt/scripts/download-trailers.sh "${FOLDER}"

