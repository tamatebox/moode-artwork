#!/bin/sh

CURRENTCOVER="../img/tmp_art.jpg"
RADIKOCOVER="../img/radiko.jpg"
PREVALBUMFILE="../txt/prev_song.txt"
RESOLUTION=$1
PREVALBUM=$(cat ${PREVALBUMFILE})

if [ "$PREVALBUM" = "Squeezelite" ]; then
	:
else
	convert "${RADIKOCOVER}" -resize ${RESOLUTION}x${RESOLUTION} "${CURRENTCOVER}"
 	echo "Squeezelite">$PREVALBUMFILE
fi