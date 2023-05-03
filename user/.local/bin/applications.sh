#!/bin/bash
set -euo pipefail

app=$(
   ls ~/.local/share/applications \
   | sed 's/\.desktop//' \
   | dmenu -i -l 32 -fn "RobotoMono-15"
)

dex "${HOME}/.local/share/applications/${app}.desktop"

