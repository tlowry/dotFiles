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
alias gom="git commit"
alias gull="git pull"
alias gush="git push"

alias c="cvs"
alias cif="cvs diff -Bbup"
alias cad="cvs add"
alias cis="cvs -qn update"
alias cek="cvs checkout"

alias ls="ls -a --color=auto"
alias ll="ls -la --color=auto"
alias la="ls -lart --color=auto"

alias eb="ebook-viewer --detach"
alias we="curl wttr.in"
alias tad="transmission-remote -a"
alias tel="transmission-remote -l"

# always collate when printing
alias lp="lp -o sides=two-sided-long-edge"
alias o="xdg-open"

alias listen="nc -vv -l 0.0.0.0"

shopt -s cdspell

dcon () { docker exec -it "$1" sh; }
export -f dcon

co () {
    PREVTERM="$TERM"
    TERM='xterm-256color'
    u="$USER"
    [ -z "$2" ] || u="$2"
    ssh "$u@$1";
    TERM="$PREVTERM"
}
export -f co

mu () { mkdir "$1" && cd "$1"; }
export -f mu

ff () {
    find . -name "*$1*" 2>/dev/null 
}
export -f ff

alias s="sudo"

dl () {
    wget -q "$1"
}
export -f dl

flib () {
    ldconfig -p | grep -i "$1"
}
export -f flib

tinfo () { transmission-remote -t "$1" -i; }
export -f tinfo

trm () { transmission-remote -t "$1" -r; }
export -f trm

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
revert () { cvs update -C "$1"; }
export -f revert

# cvs command to check for modified files
modded () { cvs -qn update | grep "^[A|M]"; }
export -f modded

alias diff="diff -bBup"
alias fid="cvs diff -bBup "$@""
alias rg="rg --hidden"

# enable vi mode editing in bash
set -o vi

# add bin + dependency path to PATH
[ -z $PATH ] && export PATH
export PATH=$PATH:$DOT_LOC/bin

#export PATH=`pathmerge "$PATH" "$HOME/.local/bin"`

# add portable system libs 
if [[ -z "${LD_LIBRARY_PATH}" ]]; then
    LD_LIBRARY_PATH=$DOT_LOC/bin/lib
else
    LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$DOT_LOC/lib
fi

export LD_LIBRARY_PATH

loc_py_path="$DOT_LOC/bin/lib/cogapp-2.5.1"
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
export VISUAL="vim"

alias gdb="gdb -nh -x $XDG_CONFIG_HOME/gdb/init"
alias tmux="tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf"
[ -z $BROWSER ] && export BROWSER="brave"
[ -z $TERMINAL ] && export TERMINAL="alacritty"

# python virtualenv setup 
ve() {
    env_name="_venv"
    [ -f "$env_name" ] || virtualenv "$env_name"
    source "$env_name"/bin/activate
}

# fuzzy cd with fzf : github.com/junegunn/fzf/wiki/examples#changing-directory
fuzz_cd(){ 
    dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf ) && cd "$dir" 
}

x_reload() {
    # only run if x open, massive delay & error otherwise
    [ -z $DISPLAY ] || xrdb -merge ~/.config/Xresources
    return 0
}

shell_reload(){
    bind -f  ~/.inputrc && . ~/.bashrc && echo "shell reloaded"
}

# key bindings
bind -x '"\C-xf": fzf'
bind -x '"\C-xc": fuzz_cd'
bind -x '"\C-xv": fuzz_edit'
bind -x '"\C-xr": shell_reload'
