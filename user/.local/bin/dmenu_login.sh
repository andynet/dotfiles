#!/bin/sh
set -euo

option=$(
    printf "Lock\nReload\nExit\nSleep\nShutdown\nReboot"                        \
    | dmenu -i -l 6 -fn "Roboto Mono Nerd Font-15"                              \
        -nf "#fbf1c7" -sf "#fbf1c7" -nb "#1d2021" -sb "#98971a"

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

