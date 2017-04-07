#!/bin/bash

PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

# Fix all missing subtitles from Movies
find /mnt/MEDIA/Movies/ -type f -iname "* (????).???" -exec /opt/filebot/filebot.sh --lang=en -get-subtitles {} \;
find /mnt/MEDIA/Movies/ -type f -iname "* (????).???" -exec /opt/filebot/filebot.sh --lang=pb -get-subtitles {} \;

# Check here if the subtitles was found

#### if subtitle was ok on this movie, add it to exclude list

#### Change the above find command to exclude paths from exclude list

#### Do the same to tv shows down here

# Fix all missing subtitles from TV Shows
find /mnt/MEDIA/TV\ Shows/ -type f -iregex "^.*\.\(mkv\|mp4\|m4v\|avi\)$" -exec /opt/filebot/filebot.sh --lang=en -get-subtitles {} \;
find /mnt/MEDIA/TV\ Shows/ -type f -iregex "^.*\.\(mkv\|mp4\|m4v\|avi\)$" -exec /opt/filebot/filebot.sh --lang=pb -get-subtitles {} \;

# Fix all permissions from all Media
chown -R plex: /mnt/MEDIA/Movies/
find /mnt/MEDIA/Movies/ -type f -exec chmod 664 {} \;
find /mnt/MEDIA/Movies/ -type d -exec chmod 775 {} \;
chown -R plex: /mnt/MEDIA/TV\ Shows/
find /mnt/MEDIA/TV\ Shows/ -type f -exec chmod 664 {} \;
find /mnt/MEDIA/TV\ Shows/ -type d -exec chmod 775 {} \;
chown -R plex: /mnt/MEDIA/Kids/
find /mnt/MEDIA/Kids/ -type f -exec chmod 664 {} \;
find /mnt/MEDIA/Kids/ -type d -exec chmod 775 {} \;
