# If not running interactively, don't do anything
[[ $- != *i* ]] && return;

echo "Loading bashrc..."
# setfont ter-124b

export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
export CONDARC="$XDG_CONFIG_HOME/conda/condarc"
export LC_COLLATE="C"
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup

PATH="/usr/local/texlive/2022/bin/x86_64-linux:$PATH"

shopt -s checkwinsize   # adjust window size after each command
# shopt -s globstar     # allow "**" pathname expansion
shopt -s extglob        # extended globbing used in HISTIGNORE
shopt -s histappend     # append to the history file, don't overwrite it

# history
HISTSIZE=-1
HISTFILESIZE=-1
HISTFILE="$XDG_STATE_HOME"/bash/history
HISTTIMEFORMAT='%F %T '
HISTIGNORE='+([a-z])*([\t ])'
HISTCONTROL='ignorespace:erasedups'  # ignore duplicate and space-starting lines

export TASKRC="$XDG_CONFIG_HOME/task/taskrc"
TASKDATA="$XDG_STATE_HOME/task/"

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

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

alias ls='ls --color=auto --group-directories-first'
alias ll='ls -lhF'
alias la='ls -A'
alias l='ls -CF'
alias lsd='ls -d .*'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias tree='tree --dirsfirst'
alias tl='task next -BLOCKED'

# limits recursive functions, see 'man bash'
[[ -z "$FUNCNEST" ]] && FUNCNEST=100

# Use the up and down arrow keys for finding a command in history
# (you can write some initial letters of the command first).
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'


if [[ -x "$HOME/.conda/bin/conda" ]]; then
    eval "$(/home/balaz/.conda/bin/conda shell.bash hook)"
fi

if [[ -e "$CARGO_HOME/env" ]]; then
    source "/home/balaz/.local/share/cargo/env"
fi
