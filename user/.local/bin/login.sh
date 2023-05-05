#!/bin/bash
set -euo pipefail

option=$(
    echo -e "Lock\nReload\nExit\nSleep\nShutdown\nReboot" \
    | dmenu -i -l 6 -fn "Roboto Mono Nerd Font-15"
)

case $option in
    "Lock")     i3lock -c 000000 -f;;
    "Reload")   i3 restart;;
    "Exit")     i3-msg exit;;
    "Sleep")    systemctl hibernate;;
    "Shutdown") shutdown now;;
    "Reboot")   reboot;;
    *)          i3-nagbar -m "Unknown option." -f "pango:Roboto Mono 15";;
esac

