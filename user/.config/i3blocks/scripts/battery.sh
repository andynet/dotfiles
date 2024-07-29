#!/bin/bash

bat=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0)
cap=$(echo "$bat" | grep "capacity:" | tr -s ' ' | cut -f3 -d" ")
perc=$(echo "$bat" | grep "percentage:" | tr -s ' ' | cut -f3 -d" ")
state=$(echo "$bat" | grep "state:" | tr -s ' ' | cut -f3 -d" ")
# tte=$(echo "$bat" | grep "time to empty:" | tr -s ' ' | cut -f5 -d" ")

cap=${cap%.*}%

case $state in
    "discharging")      state="󰁿";;
    "charging")         state="󰂄";;
    "fully-charged")    state="󰁹";;
esac

echo "$state $perc/$cap"
