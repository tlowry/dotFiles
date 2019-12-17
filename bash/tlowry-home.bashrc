alias vi=nvim
alias work='cd /home/tony/web/tlowry-site/ && sh run.sh'
alias worki='cd /home/tony/web/tlowry-site/src/pages'
export TCAL=/home/tony/gdrive/folders/projects/trainercal

export PATH=$PATH:~/.yarn/bin

setxkbmap us
#docker
DCMD='docker run -it --mount type=bind,source=$(pwd),target=/x comfy'
#alias nvim=$DCMD' nvim'
#alias python3=$DCMD' python3'
alias clang=$DCMD' clang'
#alias git=$DCMD' git'
alias pip=$DCMD' pip'
alias xon=$DCMD' xonsh'
alias comfy=$DCMD' sh'
alias xon2='docker run -it  xonsh/xonsh /usr/bin/xonsh'
PATH=$PATH:~/scripts
