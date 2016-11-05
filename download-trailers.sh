#!/bin/bash

# download trailers from themoviedb website

PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

FOLDER="$1"

M_NFO="movie.nfo"
M_PATTERN="trailer"
    
cd "${FOLDER}"
    
if [ -f $M_NFO ]; then
     
    M_NUM=$(grep -c "$M_PATTERN" $M_NFO)
        
    if [[ $M_NUM -ge 1 ]]; then
            
        IFS=$'\n'
        for M_LINE in `grep "$M_PATTERN" $M_NFO`; do
            echo $M_LINE
            T_DESC=$(echo $M_LINE | grep -oP "name='\K[^']*")
            echo "T_DESC = ${T_DESC}"
            T_URL=$(echo $M_LINE | grep -oP ">\K[^<]*")
            echo "T_URL = ${T_URL}"
            youtube-dl -f 22 -o "${T_DESC}-trailer.%(ext)s" "${T_URL}"
            echo "Just executed: youtube-dl -f 22 -o \"${T_DESC}-trailer.%(ext)s\" \"${T_URL}\""
        done
            
    fi
        
fi
