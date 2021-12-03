#!/bin/sh

PREVALBUMFILE="../txt/prev_song.txt"
MAINDIR="/Volumes/"
RESOLUTION=$1
PREVALBUM=$2

CURENTALBUM=$(ncmpcpp --current-song "%a-%b")
SONGDIR=$(ncmpcpp --current-song "%D")
DIR="${MAINDIR}${SONGDIR}"
RES=`find "${DIR}" -maxdepth 1 -name Folder* 2>/dev/null`

if [ "$CURENTALBUM" = "$PREVALBUM" ]; then
	:
else
	echo $CURENTALBUM>$PREVALBUMFILE
	if [ $? -ne 0 ]; then
		:
	elif [ -z "${RES}" ]; then
		convert ../img/default_cover.jpg -resize ${RESOLUTION}x${RESOLUTION} ../img/tmp_art.jpg
	else
		convert "${RES}" -resize ${RESOLUTION}x${RESOLUTION}! ../img/tmp_art.jpg
	fi
fi