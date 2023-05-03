#!/bin/bash

blocked_id="$1"
arguments="${@:2}"

output=`task add $arguments`
newid=`echo $output | grep -e "[0-9]*" -o`
echo "new id is $newid"

task $blocked_id modify depends:$newid

