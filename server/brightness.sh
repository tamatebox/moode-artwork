#!/bin/sh
BRIGHTNESS=$(cat brightness.txt)
MOVE=$1
SERVER=$(pgrep ft-server)

if [ "$MOVE" = "up" ]; then
	NEWBRIGHTNESS=$(($BRIGHTNESS+10))
else
	NEWBRIGHTNESS=$((BRIGHTNESS-10))
fi

if [[ $NEWBRIGHTNESS -ge 100 ]]; then
	NEWBRIGHTNESS=100
elif [[ $NEWBRIGHTNESS -le 10 ]]; then
	NEWBRIGHTNESS=10
else
	:
fi

echo $NEWBRIGHTNESS > brightness.txt

if [ "$SERVER" = "" ]; then
	:
else
	sudo kill $SERVER
	source cover.sh start
fi
