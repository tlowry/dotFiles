CFG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
. "$CFG_DIR"/shell/shellrc

# enable vi mode editing in bash
set -o vi
shopt -s cdspell

# key bindings
bind -x '"\C-xf": fzf'
bind -x '"\C-xc": fuzz_cd'
bind -x '"\C-xv": fuzz_edit'
bind -x '"\C-xr": shell_reload'
