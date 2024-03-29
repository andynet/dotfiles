#!/bin/bash
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

shopt -s checkwinsize   # adjust window size after each command
# shopt -s globstar # allow "**" pathname expansion
shopt -s extglob        # extended globbing used in HISTIGNORE
shopt -s histappend     # append to the history file, don't overwrite it

# history
mkdir -p "${XDG_STATE_HOME}/bash"
touch "${XDG_STATE_HOME}/bash/history"
HISTSIZE=-1
HISTFILESIZE=-1
HISTFILE="$XDG_STATE_HOME/bash/history"
HISTTIMEFORMAT='%F %T '
HISTIGNORE='+([a-z])*([\t ])'
HISTCONTROL='ignorespace:erasedups'  # ignore duplicate and space-st>

# ulimit -c unlimited   # store core dumps

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

function bash_prompt {
    local C1="\[\033[01;32m\]"  # bright green
    local C2="\[\033[00m\]"     # default color
    local C3="\[\033[01;34m\]"  # bright blue
    PS1="${C1}\u@\h${C2}:${C3}\w${C2} \!\$ "
}
bash_prompt

alias ..='cd ..'
alias ...='cd ../../'

alias ls='ls --color=auto --group-directories-first'
alias la='ls --color=auto --group-directories-first -A'
alias ll='ls --color=auto --group-directories-first -lh'
alias l.='ls --color=auto --group-directories-first -d .!(|.)'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias tree='tree --dirsfirst'
alias tl='task next -BLOCKED rc.verbose:nothing'
alias gd='google-drive-ocamlfuse ~/gdrive && echo "Gdrive mounted"'
alias gdx='fusermount -u ~/gdrive && echo "Gdrive exited"'
alias gui="startx > session.log 2>&1"
alias mamba="micromamba"
alias snake="snakemake -c4 -s scripts/vinkofagy/heterozygosity.smk"
alias avim="NVIM_APPNAME=astronvim nvim"
alias kvim="NVIM_APPNAME=kickstart nvim"
alias vim="nvim"
alias config="git -C ~/.dotfiles"

# limits recursive functions, see 'man bash'
[[ -z "$FUNCNEST" ]] && FUNCNEST=100

# Use the up and down arrow keys for finding a command in history
# (you can write some initial letters of the command first).
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

# make completion
# https://stackoverflow.com/a/38415982
complete -W "\`grep -oE '^[a-zA-Z0-9_.-]+:([^=]|$)' ?akefile | sed 's/[^a-zA-Z0-9_.-]*$//'\`" make

# if [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z ${BASH_EXECUTION_STRING} ]]
# then
    # exec fish
# fi

if [[ -e "$CARGO_HOME/env" ]]; then
	source "/home/balaz/.local/share/cargo/env"
fi

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
export MAMBA_EXE="/home/balaz/.dotfiles/user/.local/bin/micromamba";
export MAMBA_ROOT_PREFIX="/home/balaz/.local/share/micromamba";
__mamba_setup="$("$MAMBA_EXE" shell hook --shell bash --prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
# shellcheck disable=SC2181
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    if [ -f "/home/balaz/.local/share/micromamba/etc/profile.d/micromamba.sh" ]; then
        . "/home/balaz/.local/share/micromamba/etc/profile.d/micromamba.sh"
    else
        export  PATH="/home/balaz/.local/share/micromamba/bin:$PATH"  # extra space after export prevents interference from conda init
    fi
fi
unset __mamba_setup
# <<< mamba initialize <<<

function n() {
    [ "${NNNLVL:-0}" -eq 0 ] || {
        echo "nnn is already running"
        return
    }

    NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    command nnn -d -e "$@"

    [ ! -f "$NNN_TMPFILE" ] || {
        # shellcheck source=/dev/null
        source "$NNN_TMPFILE"
        rm -f "$NNN_TMPFILE" > /dev/null
    }
}
