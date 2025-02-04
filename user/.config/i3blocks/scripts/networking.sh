#!/bin/bash

active=$(nmcli -f IN-USE,SIGNAL,SSID device wifi list | grep "^\*")
ssid=$(echo "$active" | tr -s " " | cut -f3- -d " ")
signal=$(echo "$active" | tr -s " " | cut -f2 -d " ")

if [[ -z "$ssid" ]]; then
    echo "󰖪 "  # nf-md-wifi_off
else
    echo "󰖩 $ssid ($signal%)"  # nf-md-wifi
fi
