#!/bin/bash
#### auto-process download with filebot
#### this script executes right after a download finishes
#### https://github.com/allangarcia/seedbox-to-plex-automation

PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
[ -r /etc/environment ] && . /etc/environment

# Input variables
TORRENT_ID="$1"
TORRENT_NAME="$2"
TORRENT_PATH="$3"

# Global constants
OUTPUT_PATH="${MEDIA_PATH}"
WORKING_PATH="/opt/filebot/cache"

# Sanity check
[ -d $WORKING_PATH ] || mkdir -p $WORKING_PATH

# Main execution
sudo /opt/filebot/filebot.sh \
	-script fn:amc \
	-non-strict \
	--action duplicate \
	--conflict override \
	--output "${OUTPUT_PATH}" \
	--log-file "${WORKING_PATH}/filebot-process.log" \
	--def \
		subtitles=eng,pob \
		extras=n \
		unsorted=y \
		artwork=y \
		excludeList=${WORKING_PATH}/filebot-excludes.txt \
		"ut_dir=$TORRENT_PATH/$TORRENT_NAME" \
		"ut_kind=multi" \
		"ut_title=$TORRENT_NAME" \
		"exec=/opt/scripts/post-process.sh '{file}' '{folder}'"

# Remove original directory after duplicate
rm -rf "$TORRENT_PATH/$TORRENT_NAME"
