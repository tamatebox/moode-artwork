#!/bin/sh

CURRENTSONGFILE="/var/local/www/currentsong.txt"
SPOTIFYINFO="../txt/spotify.txt"
SQPS=$(pgrep squeezelite)
CURRENTSTATE=$(cat ${SPOTIFYINFO})
read FILE < $CURRENTSONGFILE

if [ "$FILE" = "file=Spotify Active" ]; then
	if [ "$CURRENTSTATE" = "True" ]; then
		:
	else
		echo "True">$SPOTIFYINFO
	fi
elif [ "$SQPS" != "" ]; then
	if [ "$CURRENTSTATE" = "Squeezelite" ]; then
		:
	else
		echo "Squeezelite">$SPOTIFYINFO
	fi
elif [ "$FILE" = "file=Airplay Active" ]; then
	if [ "$CURRENTSTATE" = "AirPlay" ]; then
		:
	else
		echo "AirPlay">$SPOTIFYINFO
	fi
elif [ "$FILE" = "file=" ]; then
	if [ "$CURRENTSTATE" = "None" ]; then
		:
	else
		echo "None">$SPOTIFYINFO
	fi
else
	if [ "$CURRENTSTATE" = "False" ]; then
		:
	else
		echo "False">$SPOTIFYINFO
	fi
fi