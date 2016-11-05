#!/bin/bash

PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

TORRENT_ID="$1"
TORRENT_NAME="$2"
TORRENT_PATH="$3"

OUTPUT_PATH="/mnt/MEDIA"
WORKING_PATH="/opt/filebot/cache"

sudo /opt/filebot/filebot.sh \
	-script fn:amc \
	-non-strict \
	--action move \
	--conflict auto \
	--output "${OUTPUT_PATH}" \
	--log-file "${WORKING_PATH}/filebot-process.log" \
	--def \
		subtitles=eng,pob \
		excludeList=${WORKING_PATH}/filebot-excludes.txt \
		extras=y \
		unsorted=y \
		music=y \
		artwork=y \
		"ut_dir=$TORRENT_PATH/$TORRENT_NAME" \
		"ut_kind=multi" \
		"ut_title=$TORRENT_NAME" \
		"exec=/opt/scripts/post-process.sh '{file}' '{folder}'"
