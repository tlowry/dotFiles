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

# useful CVS
revert () { cvs update -C $1; }
export -f revert

# cvs command to check for modified files
modded () { cvs -qn update | grep "^[A|M]"; }
export -f modded

alias diff="diff -bBup"
alias fid="cvs diff -bBup "$@""
alias rg="rg --hidden"

#useful history datestamps
export HISTTIMEFORMAT='%F %T  '

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

# fuzzy cd with fzf : github.com/junegunn/fzf/wiki/examples#changing-directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

#fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() (
   IFS=$'\n' files=($(fzf --query="$1" --multi --select-1 --exit-0))
     [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
)

# exports

export XDG_CONFIG_HOME=~/.config
export XDG_DATA_HOME="$HOME/.local/share"

export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="-"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export INPUTRC="${XDG_CONFIG_HOME:-$HOME/.config}/inputrc"
export ALSA_CONFIG_PATH="$XDG_CONFIG_HOME/alsa/asoundrc"
export WINEPREFIX="${XDG_DATA_HOME:-$HOME/.local/share}/wineprefixes/default"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export ANDROID_SDK_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/android"
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export FZF_DEFAULT_COMMAND='rg --files --hidden -g '!.git/*''
export stor="/run/media/stor"
export EDITOR="vim"

[ -z $BROWSER ] && export BROWSER="icecat"
[ -z $TERMINAL ] && export TERMINAL="alacritty"

# key bindings
bind -x '"\C-xf": fzf'
bind -x '"\C-xc": fd'
bind -x '"\C-xv": fe'
bind -x '"\C-xr": . ~/.bashrc && echo "reloaded bashrc"'
