#!/bin/bash
#### download-trailers using themoviedb api
#### this scripts executes in the middle of post-process execution
#### https://github.com/allangarcia/seedbox-to-plex-automation

PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
[ -r /etc/environment ] && . /etc/environment

# Input variables
FOLDER="$1"

# Global constants
API_KEY="${TMDB_KEY}"
LANG="pt-BR"
M_NFO="movie.nfo"

# Execution variables
M_TRAILER_KEY=""
M_TRAILER_NAME=""
M_TRAILER_YOUTUBE=0

cd "${FOLDER}"

if [ -f $M_NFO ]; then

    # Getting the movie id
    M_ID=$(cat $M_NFO | grep "tmdb" | grep -oP "id='\K[^']*")

    # Asking themoviedb for videos
    M_RESPONSE=$(curl -s -o - --request GET --url "https://api.themoviedb.org/3/movie/${M_ID}/videos?language=${LANG}&api_key=${API_KEY}" --data "{}")

    # Checking if we have some trailers
    M_NUM=$(echo "$M_RESPONSE" | grep -c "Trailer")

    if [[ $M_NUM -ge 1 ]]; then

        # Ugly parser, but works
        # Maybe I should install jq
        IFS=$'},{'
        for M_LINE in `echo "$M_RESPONSE" | grep -oP "\[\K[^\]]*"`; do
            if [[ "$M_LINE" =~ "key" ]]; then
              M_TRAILER_KEY=$(echo $M_LINE | grep -oP ":\"\K(\w+)")
            fi
            if [[ "$M_LINE" =~ "name" ]]; then
              M_TRAILER_NAME=$(echo $M_LINE | grep -oP ":\"\K([\w -]+)")
            fi
            if [[ "$M_LINE" =~ "site" ]]; then
              M_TRAILER_YOUTUBE=0
              if [[ "$M_LINE" =~ "YouTube" ]]; then
                M_TRAILER_YOUTUBE=1
              fi
            fi
            if [[ "$M_LINE" =~ "type" ]]; then
              if [[ "$M_LINE" =~ "Trailer" ]]; then
                if [[ $M_TRAILER_YOUTUBE == 1 ]]; then
                  echo "Found!"
                  echo "Name: $M_TRAILER_NAME"
                  echo "Key: $M_TRAILER_KEY"
                  youtube-dl -f 22 -o "${M_TRAILER_NAME}-trailer.%(ext)s" "https://www.youtube.com/watch?v=${M_TRAILER_KEY}"
                fi
              fi
            fi
        done

    fi

fi
