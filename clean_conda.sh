#!/bin/bash

set -euxo pipefail

ENVS=$(conda env list | grep -v "#" | grep -v "^base" | tr -s " " | cut -f2 -d " ")

for env in ${ENVS}; do
    name=${env##*/};
    conda env export -p "${env}" --from-history > "$(date '+%y%m%d')_${name}.yml";
    conda env remove -p "${env}";
done;

conda update --all
conda clean -ay

# cat 220816_* > file.txt
# grep -vFf - file.txt < <(grep -B4 'dependencies' file.txt) > filtered.txt

