#!/bin/bash
#### cron-process keeps media organized
#### this scripts executes daily
#### https://github.com/allangarcia/seedbox-to-plex-automation

PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
[ -r /etc/environment ] && . /etc/environment

#TODO: Check here if the subtitles was found
#### if subtitle was ok on this movie, add it to exclude list
#### Change the above find command to exclude paths from exclude list
#### Do the same to tv shows down here

# Fix all missing subtitles from Movies

find ${MEDIA_PATH}/Movies/ -type f -iname "* (????).???" -exec /opt/filebot/filebot.sh --lang=en -get-subtitles {} \;
find ${MEDIA_PATH}/Movies/ -type f -iname "* (????).???" -exec /opt/filebot/filebot.sh --lang=pb -get-subtitles {} \;

# Fix all missing subtitles from TV Shows

find ${MEDIA_PATH}/TV\ Shows/ -type f -iregex "^.*\.\(mkv\|mp4\|m4v\|avi\)$" -exec /opt/filebot/filebot.sh --lang=en -get-subtitles {} \;
find ${MEDIA_PATH}/TV\ Shows/ -type f -iregex "^.*\.\(mkv\|mp4\|m4v\|avi\)$" -exec /opt/filebot/filebot.sh --lang=pb -get-subtitles {} \;

# Fix all permissions from all Media

chown -R plex: ${MEDIA_PATH}/Movies/
find ${MEDIA_PATH}/Movies/ -type f -exec chmod 666 {} \;
find ${MEDIA_PATH}/Movies/ -type d -exec chmod 775 {} \;

chown -R plex: ${MEDIA_PATH}/TV\ Shows/
find ${MEDIA_PATH}/TV\ Shows/ -type f -exec chmod 666 {} \;
find ${MEDIA_PATH}/TV\ Shows/ -type d -exec chmod 775 {} \;

