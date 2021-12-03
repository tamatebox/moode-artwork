#!/bin/sh

CURRENTCOVER="../img/tmp_art.jpg"
EMPTYDIR="../img/empty/"
PREVALBUMFILE="../txt/prev_song.txt"
RESOLUTION=$1
PREVALBUM=$2

if [ "$PREVALBUM" = "None" ]; then
	:
else
	EMPTYCOVER="${EMPTYDIR}$(ls ${EMPTYDIR} | shuf -n 1)"
	convert "${EMPTYCOVER}" -resize ${RESOLUTION}x${RESOLUTION}! "${CURRENTCOVER}"
 	echo "None">$PREVALBUMFILE
fi