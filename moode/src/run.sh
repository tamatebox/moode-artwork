#!/bin/sh
while true; do source ./get_cover.sh > /dev/null 2>&1 ; sleep 1; done &
while true; do source ./send_cover.sh > /dev/null 2>&1 ; sleep 1; done &