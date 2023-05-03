#!/bin/bash
set -euo pipefail

device="SynPS/2 Synaptics TouchPad"
enabled=$(xinput list-props "SynPS/2 Synaptics TouchPad" | grep -o -P ".*Device Enabled.*\K.")

[[ "$enabled" == "1" ]] && xinput disable "$device" || xinput enable "$device"

