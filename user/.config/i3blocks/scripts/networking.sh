#!/bin/bash

active=$(nmcli device wifi list | grep "^\*")
ssid=$(echo "$active" | tr -s ' ' | cut -f3 -d" ")
signal=$(echo "$active" | tr -s ' ' | cut -f8 -d" ")

echo "  $ssid ($signal%)"

# full_text= AbrahamLINKon (75%) via VPN
# or 󰛳 
# SSID
# signal strength
# VPN
