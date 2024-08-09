#!/bin/bash

disk=$(df -h | grep "sda2" | tr -s " ")
used=$(echo "$disk" | cut -f3 -d" ")
total=$(echo "$disk" | cut -f2 -d" ")

echo "󰋊 $used/$total"
