#!/usr/bin/env bash

msgTag="myvolume"

volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{ printf $5 }' | sed 's/.$//')
muted="$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{ print $2 }')"
if [[ "$muted" = "yes" ]]; then
    # Show the sound muted notification
    dunstify -a "changeVolume" -u low -i audio-volume-muted -h string:x-dunst-stack-tag:$msgTag "Volume muted (${volume}%)" 
else
    # Show the volume notification
    dunstify -a "changeVolume" -u low -i audio-volume-high -h string:x-dunst-stack-tag:$msgTag \
    -h int:value:"$volume" "Volume: ${volume}%"
fi
