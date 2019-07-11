#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Appending to PATH prevents Anaconda from being prioritized over the system $PATH.
# https://tobanwiebe.com/blog/2016/09/anaconda-python-linux
export PATH="$PATH:/home/blinklad/dev/python/anaconda3/anaconda3/bin"
export PYTHONPATH="$PYTHONPATH:/path/to/anaconda3/lib/python3.6/site-packages"

# Apply pywal theme to new terminals
# Import colorscheme asychronously

# (cat ~/.cache/wal/sequences &)

## Aliases ##

alias ls='ls -hN --color=auto' 								   # Pretty listing
alias hackerman='cat /dev/urandom' 							   # M A T R I X
alias vim='nvim'											   # Vim btw
alias cleansym='find -L $DIR -maxdepth 1 -type 1 -delete'      # Clean symlinks
alias bl+='xbacklight -inc 10'								   # Backlight increase
alias bl-='xbacklight -dec 10'								   # Backlight decrease
alias purge='python /usr/bin/purge.py'						   # Clear up _something_
alias prolog='gprolog | lolcat'								   # GNU slash Prolog
alias f='nvim $(fzf)'									       # Fuzzy open
alias fu='nvim $(find ~/Uni -type f | fzf )'				   # Fuzzy open, but educational
alias bet='cat ~/pictures/memes/bet.set | lolcat'		       # B E T
alias memcheck='valgrind -v --tool=memcheck --leak-check=full' # Leaky boi

## Functions
function cd() {
    if [[ "$#" != 0 ]]; then
        builtin cd "$@";
        return
    fi
    while true; do
        local lsd=$(echo ".." && ls -p | grep '/$' | sed 's;/$;;')
        local dir="$(printf '%s\n' "${lsd[@]}" |
            fzf --reverse --preview '
                __cd_nxt="$(echo {})";
                __cd_path="$(echo $(pwd)/${__cd_nxt} | sed "s;//;/;")";
                echo $__cd_path;
                echo;
                ls -p --color=always "${__cd_path}";
        ')"
        [[ ${#dir} != 0 ]] || return 0
        builtin cd "$dir" &> /dev/null
    done
	ls -hN --color=auto
}

## Fuzzy goodness
export FZF_DEFAULT_OPTS='
  --color=bg+:#073642,bg:#002b36,spinner:#719e07,hl:#586e75
  --color=fg:#839496,header:#586e75,info:#cb4b16,pointer:#719e07
  --color=marker:#719e07,fg+:#839496,prompt:#719e07,hl+:#719e07'

## Paths
export GOPATH=/home/blinklad/programming/go

export EDITOR=nvim
export VISUAL=nvim

## Get tmux to co-operate
## export TERM=xterm-256color

## Random
shopt -s autocd

HISTSIZE= HISTFILESIZE= 
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/home/blinklad/dev/python/anaconda3/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/home/blinklad/dev/python/anaconda3/anaconda3/etc/profile.d/conda.sh" ]; then
#         . "/home/blinklad/dev/python/anaconda3/anaconda3/etc/profile.d/conda.sh"
#     else
#		path	
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<

