#!/bin/bash

volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -o ...% | head -n1)
mute=$(pactl get-sink-mute @DEFAULT_SINK@ | cut -f2 -d" ")

case $mute in
    "yes") echo "󰝟 $volume";;
    "no")  echo " $volume";;
esac
