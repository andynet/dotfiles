# If not running interactively, don't do anything
[[ $- != *i* ]] && return;

echo "Sourced bashrc"

# history
HISTSIZE=-1
HISTFILESIZE=-1
export HISTFILE="$XDG_STATE_HOME"/bash/history
HISTTIMEFORMAT='%F %T '
HISTIGNORE='+([a-z])*([\t ])'
HISTCONTROL=ignoreboth  # ignore duplicate and space-starting lines
shopt -s histappend     # append to the history file, don't overwrite it

# ulimit -c unlimited   # store core dumps
shopt -s checkwinsize   # adjust window size after each command
#shopt -s globstar      # allow "**" pathname expansion

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# colored prompt
# PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \!\$ '

function bash_prompt {
    local C1="\[\033[01;32m\]"  # bright green
    local C2="\[\033[00m\]"     # default color
    local C3="\[\033[01;34m\]"  # bright blue
    PS1="${C1}\u@\h${C2}:${C3}\w${C2} \!\$ "
}
bash_prompt

# enable color support of ls and also add handy aliases
# https://linux.die.net/man/5/dir_colors
# eval "$(dircolors -b)" creates the LS_COLORS env variable
if [ -x /usr/bin/dircolors ]; then
    [ -r ~/.dircolors ] && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto --group-directories-first'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

alias ll='ls -lhF'
alias la='ls -A'
alias l='ls -CF'
alias tree='tree --dirsfirst'
alias lsd='ls -d .*'
alias tl="task list -BLOCKED"

# limits recursive functions, see 'man bash'
[[ -z "$FUNCNEST" ]] && export FUNCNEST=100

# Use the up and down arrow keys for finding a command in history
# (you can write some initial letters of the command first).
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
# if ! shopt -oq posix; then
#   if [ -f /usr/share/bash-completion/bash_completion ]; then
#     . /usr/share/bash-completion/bash_completion
#   elif [ -f /etc/bash_completion ]; then
#     . /etc/bash_completion
#   fi
# fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/andy/miniconda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/andy/miniconda/etc/profile.d/conda.sh" ]; then
        . "/home/andy/miniconda/etc/profile.d/conda.sh"
    else
        export PATH="/home/andy/miniconda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env";
fi
