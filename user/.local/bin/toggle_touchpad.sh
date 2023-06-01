#!/bin/bash
set -euo pipefail

# xinput list
# device="SynPS/2 Synaptics TouchPad"
device="10"
enabled=$(xinput list-props "$device" | grep -o -P ".*Device Enabled.*\K.")

[[ "$enabled" == "1" ]] && xinput disable "$device" || xinput enable "$device"

