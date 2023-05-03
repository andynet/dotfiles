#!/bin/bash

if [ -z "$1" ]; then
    exit
fi

blocked_id="$1"
arguments="${@:2}"

project=`task ${blocked_id} info | egrep "^Project" | sed -r 's/Project\W*(.*)/\1/'`

output=`task add $arguments project:${project}`
echo $output
newid=`echo $output | grep -e "[0-9]*" -o`
echo $newid

task $blocked_id modify depends:$newid
