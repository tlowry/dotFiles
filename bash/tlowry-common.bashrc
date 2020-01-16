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
    export PYTHONPATH=~/dotFiles/scripts/lib/git-cvs:~/dotFiles/scripts/lib/rcsparse
else
    PYTHONPATH=$PYTHONPATH:"$HOME/dotFiles/scripts/lib/git-cvs:$HOME/dotFiles/scripts/lib/rcsparse"
fi

# add git-cvs main scripts to path so git can find them
PATH=$PATH:$HOME/dotFiles/scripts/lib/git-cvs/scripts
export PATH
