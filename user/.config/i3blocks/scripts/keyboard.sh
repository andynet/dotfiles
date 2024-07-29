#!/bin/bash

# text=htt us
# first 3 letters in the clipboard
# us/sk

# clipboard=$(xclip -o | head -c 3)

layout=$(xset -q | grep LED | awk '{ print $10 }')
case $layout in
  "00000000") layout="us" ;;
  "00001000") layout="sk" ;;
  *) layout="??" ;;
esac

# echo "$clipboard $layout"
echo "$layout"
