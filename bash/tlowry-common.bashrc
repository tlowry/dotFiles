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
alias gd="git diff"
alias ga="git add"
alias gis="git status"

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

export FZF_DEFAULT_COMMAND='rg --files --hidden -g '!.git/*''
export EDITOR='vim'
#export XDG_CONFIG_HOME=$DOT_LOC/.config

# key bindings
bind -x '"\C-xf": fzf'
bind -x '"\C-xc": fd'
bind -x '"\C-xv": fe'
bind -x '"\C-xr": . ~/.bashrc && echo "reloaded bashrc"'
