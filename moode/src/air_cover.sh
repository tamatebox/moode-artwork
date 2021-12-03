#!/bin/sh

PREVCOVER="../img/tmp_art.jpg"
DIR="/tmp/shairport-sync/.cache/coverart"
RESOLUTION=$1

RES=`find "${DIR}" -maxdepth 1 -name *jpg 2>/dev/null`
if [ $? -ne 0 ]; then
	:
elif [ -z "${RES}" ]; then
	convert ../img/default_cover.jpg -resize ${RESOLUTION}x${RESOLUTION} ../img/tmp_art.jpg
else
	HASH1=$(md5sum $PREVCOVER | cut -d ' ' -f 1)
	HASH2=$(md5sum $RES | cut -d ' ' -f 1)
	if [ "$HASH1" = "$HASH2" ]; then
			:
	else
		convert "${RES}" -resize ${RESOLUTION}x${RESOLUTION}! ../img/tmp_art.jpg
	fi
fi