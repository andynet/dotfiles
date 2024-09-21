#!/bin/bash

set -euxo pipefail

# ENVS=$(micromamba env list | grep -v "#" | grep -v "^base" | tr -s " " | cut -f2 -d " ")
ENVS=$(micromamba env list | tail -n +12 | grep -v "#" | grep -v "^base" | tr -s " " | cut -f2 -d " ")

for env in ${ENVS}; do
    name=${env##*/};
    micromamba env export -p "${env}" --from-history > "$(date '+%y%m%d')_${name}.yml";
    micromamba env remove -p "${env}";
done;

micromamba update --all
micromamba clean -ay

# cat 220816_* > file.txt
# grep -vFf - file.txt < <(grep -B4 'dependencies' file.txt) > filtered.txt

