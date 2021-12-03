#!/bin/sh

RESOLUTION="64"
SENDDIR="raspi.local"
CURRENTCOVER="../img/art.jpg"
NEWCOVER="../img/tmp_art.jpg"

HASH1=$(md5sum $CURRENTCOVER | cut -d ' ' -f 1)
HASH2=$(md5sum $NEWCOVER | cut -d ' ' -f 1)

if [ "$HASH1" = "$HASH2" ]; then
	:
else
	./send-image -h $SENDDIR -g ${RESOLUTION}x${RESOLUTION} $NEWCOVER
	cp $NEWCOVER $CURRENTCOVER
fi