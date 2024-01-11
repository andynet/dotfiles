#!/bin/sh
set -euo

cd "${HOME}/.local/share/applications"
app=$(
    find . -name "*.desktop" \
    | sed 's/\.\///;s/\.desktop//' \
    | dmenu -i -l 32 -fn "Roboto Mono Nerd Font-15" \
        -nf "#fbf1c7" -sf "#fbf1c7" -nb "#1d2021" -sb "#98971a"
)

dex "${HOME}/.local/share/applications/${app}.desktop"

