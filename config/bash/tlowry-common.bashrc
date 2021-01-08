. ~/.config/shell/shellrc

# enable vi mode editing in bash
set -o vi
shopt -s cdspell

shell_reload(){
    bind -f  ~/.inputrc && . ~/.bashrc && echo "shell reloaded" && return 0
}

pp () { [ -z "$1" ] && echo "use pp <proc> " && return 1; kill -9 `ps -ef | grep -v "grep" | grep "$1" | awk '{ print $2 }'` ;}
export -f pp

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

zf () { zip -r "$1".zip "$1"; }
export -f zf

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

repl () {
    find ./ -type f -exec sed -i -e "s/$1/$2/g" {} \;
}
export -f repl 

# useful CVS
revert () { cvs update -C "$1"; }
export -f revert

# cvs command to check for modified files
modded () { cvs -qn update | grep "^[A|M]"; }
export -f modded

# key bindings
bind -x '"\C-xf": fzf'
bind -x '"\C-xc": fuzz_cd'
bind -x '"\C-xv": fuzz_edit'
bind -x '"\C-xr": shell_reload'
