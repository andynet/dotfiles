#!/bin/bash
set -euo pipefail

app=$(
   ls ~/.local/share/applications \
   | sed 's/\.desktop//' \
   | dmenu -i -l 32 -fn "Roboto Mono Nerd Font-15"
)

dex "${HOME}/.local/share/applications/${app}.desktop"

