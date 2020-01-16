# Bash config for home pc

#US kbd?
localectl set-x11-keymap us
setxkbmap us

alias vi=nvim
alias work='cd /home/tony/web/tlowry-site/ && sh run.sh'
alias worki='cd /home/tony/web/tlowry-site/src/pages'
export TCAL=/home/tony/gdrive/folders/projects/trainercal

# aliases for docker run commands
DCMD='docker run -it --mount type=bind,source=$(pwd),target=/x comfy'
#alias nvim=$DCMD' nvim'
alias clang=$DCMD' clang'
alias pip=$DCMD' pip'
alias xon=$DCMD' xonsh'
alias comfy=$DCMD' sh'
alias xon2='docker run -it  xonsh/xonsh /usr/bin/xonsh'

export PATH=$PATH:~/.yarn/bin
PATH=$PATH:~/scripts
