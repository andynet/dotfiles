function fish_right_prompt -d "Write out the right prompt"
    # date '+%m/%d/%y'
    # number of commands
    # git branch
    # mamba env
    # path
    # host
    # user
    # exit status of previous command
    echo -sn (fish_vcs_prompt)
    set -l ntasks (task rc.gc=off status:pending count 2>/dev/null)
    echo -sn $ntasks
end
