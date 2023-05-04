#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# # remove env variables except XDG_RUNTIME_DIR and HOME
# for var in $(env | cut -f1 -d"="); do
#     case $var in
#         XDG_RUNTIME_DIR);;
#         HOME);;
#         TERM);;
#         LANG);;
# #         *) unset $var;;
#     esac;
# done;

# export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/sbin"
# if [ -n "$BASH_VERSION" ]; then
#     if [ -f "$HOME/.bashrc" ]; then
#         source "$HOME/.bashrc"
#     fi
# fi

