#!/bin/sh

SERVER=$(pgrep ft-server)
BRIGHTNESS=$(cat brightness.txt)
POWER=$1

if [ "$SERVER" = "" ]; then
	if [ "$POWER" = "start" ]; then
		sudo ./flaschen-taschen/server/ft-server -d --led-slowdown-gpio=2 --led-rows=64 --led-cols=64 --led-show-refresh --led-brightness="$BRIGHTNESS"
	else
		:
	fi
else
	if [ "$POWER" = "start" ]; then
		:
	else
		sudo kill $SERVER
	fi
fi
