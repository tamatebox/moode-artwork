#!/bin/sh

source check_spotify.sh

RESOLUTION="128"

SPOTIFYINFO="../txt/spotify.txt"
SPOTIFY=$(cat $SPOTIFYINFO)
PREVALBUMFILE="../txt/prev_song.txt"
PREVALBUM=$(cat ${PREVALBUMFILE})

if [ "$SPOTIFY" = "True" ]; then
	python3 spotify_cover.py $RESOLUTION "${PREVALBUM}"
elif [ "$SPOTIFY" = "Squeezelite" ]; then
	source ./sqe_cover.sh $RESOLUTION
elif [ "$SPOTIFY" = "AirPlay" ]; then
	source ./air_cover.sh $RESOLUTION
	echo "AirPlay">$PREVALBUMFILE
elif [ "$SPOTIFY" = "None" ] ; then
	source ./empty_cover.sh $RESOLUTION "${PREVALBUM}"
else
	source ./mpd_cover.sh $RESOLUTION "${PREVALBUM}"
fi