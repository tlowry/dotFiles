# Annoying mispellings
alias gamek="gmake"
alias gamke="gmake"
alias gmaek="gmake"
alias gmkae="gmake"
alias ci="vim"
alias vu="vim"
alias vo="vim"
alias vi="vim"

alias g="git"
alias gif="git diff"
alias gad="git add"
alias gis="git status"
alias gek="git checkout"

alias c="cvs"
alias cif="cvs diff -Bbup"
alias cad="cvs add"
alias cis="cvs -qn update"
alias cek="cvs checkout"

alias ls="ls -a --color=auto"
alias ll="ls -la --color=auto"
alias la="ls -lart --color=auto"

alias eb="ebook-viewer --detach"
alias vncserver="vncserver -noreset -geometry 1600x900"

# Small less enhancements
export LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=-4'
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# useful CVS
revert () { cvs update -C $1; }
export -f revert

# cvs command to check for modified files
modded () { cvs -qn update | grep "^[A|M]"; }
export -f modded

alias diff="diff -bBup"
alias fid="cvs diff -bBup "$@""
alias rg="rg --hidden"

# enable vi mode editing in bash
set -o vi

# add scripts + dependency path to PATH
[ -z $PATH ] && export PATH
export PATH=$PATH:$DOT_LOC/scripts

# add portable system libs 
if [[ -z "${LD_LIBRARY_PATH}" ]]; then
    LD_LIBRARY_PATH=$DOT_LOC/scripts/lib
else
    LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$DOT_LOC/lib
fi

export LD_LIBRARY_PATH

loc_py_path="$DOT_LOC/scripts/lib/cogapp-2.5.1"
# add portable python libs + dependent libs
if [[ -z "${PYTHON_PATH}" ]]; then
    export PYTHONPATH=$loc_py_path
else
    export PYTHONPATH=$PYTHONPATH:$loc_py_path
fi
# exports

#useful history datestamps
export HISTTIMEFORMAT='%F %T  '
export HISTCONTROL=ignoredups # don't add duplicate commands to bash history

export XDG_CONFIG_HOME=~/.config
export XDG_DATA_HOME="$HOME/.local/share"
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="-"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export INPUTRC="${XDG_CONFIG_HOME:-$HOME/.config}/inputrc"
export WINEPREFIX="${XDG_DATA_HOME:-$HOME/.local/share}/wineprefixes/default"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export ANDROID_SDK_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/android"
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export FZF_DEFAULT_COMMAND='rg --files --hidden -g '!.git/*''
export stor="/run/media/stor"
export EDITOR="vim"

alias tmux="tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf"
[ -z $BROWSER ] && export BROWSER="brave"
[ -z $TERMINAL ] && export TERMINAL="alacritty"

# fuzzy cd with fzf : github.com/junegunn/fzf/wiki/examples#changing-directory
fuzz_cd(){ 
    dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf ) && cd "$dir" 
}

shell_reload(){
    bind -f  ~/.inputrc && . ~/.bashrc && xrdb ~/.config/.Xresources && echo "shell reloaded"
}

# key bindings
bind -x '"\C-xf": fzf'
bind -x '"\C-xc": fuzz_cd'
bind -x '"\C-xv": fuzz_edit'
bind -x '"\C-xr": shell_reload'
