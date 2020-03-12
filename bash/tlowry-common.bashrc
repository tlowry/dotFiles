# Annoying mispellings
alias gamek="gmake"
alias gamke="gmake"
alias gmaek="gmake"
alias gmkae="gmake"
alias ci="vim"
alias vu="vim"
alias vo="vim"
alias vi="vim"

# useful CVS
revert () { cvs update -C $1; }
export -f revert

# cvs command to check for modified files
modded () { cvs -qn update | grep "^[A|M]"; }
export -f modded

alias diff="diff -bBup"
alias fid="cvs diff -bBup "$@""
#alias class="python ~/dotFiles/scripts/make_class.py "$1""
#alias test="python ~/dotFiles/make_class.py $1 ~/scripts/templates/test.h ~/scripts/templates/test.cpp"

export WR=~

. ~/dotFiles/scripts/util.sh
export PATH
PATH=$PATH:~/bak
export PYLIB=$HOME/scripts/lib/
export PATH=$PATH:$HOME/scripts
export PATH=$PATH:$HOME/scripts/dev/
export PATH=$PATH:$HOME/dotFiles/scripts
export PATH=$PATH:$HOME/dotFiles/scripts/dev

#useful history datestamps
export HISTTIMEFORMAT='%F %T  '

if [[ -z "${PYTHON_PATH}" ]]; then
    export PYTHONPATH=~/dotFiles/scripts/lib/git-cvs:~/dotFiles/lib
else
    export PYTHONPATH=$PYTHONPATH:"$HOME/dotFiles/scripts/lib/git-cvs:$HOME/dotFiles/lib"
fi

if [[ -z "${LD_LIBRARY_PATH}" ]]; then
    LD_LIBRARY_PATH=~/dotFiles/lib
else
    LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/dotFiles/lib
fi

export LD_LIBRARY_PATH

# enable vi mode editing in bash
set -o vi

# add git-cvs main scripts to path so git can find them
PATH=$PATH:$HOME/dotFiles/scripts/lib/git-cvs/scripts
export PATH

alias workpy='conda activate mlwork && cd ~/pywork'
alias fin='conda deactivate'
alias pip='pip3'

# fuzzy cd with fzf : github.com/junegunn/fzf/wiki/examples#changing-directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

bind -x '"\C-xf": fzf'
bind -x '"\C-xc": fd'

#fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() (
   IFS=$'\n' files=($(fzf --query="$1" --multi --select-1 --exit-0))
     [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
)

bind -x '"\C-xv": fe'
