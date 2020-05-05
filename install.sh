#!/bin/bash

# find the current location of this script
DOT_LOC="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

. $DOT_LOC/scripts/util.sh
append_if_missing "export DOT_LOC=$DOT_LOC" ~/.bashrc

make_link () {
    dest_dir=`dirname $2` 2> /dev/null
    [ -f $dest_dir ] || mkdir -p $dest_dir
    [ -L $2 ] && unlink $2
    [ -L $2 ] || ln -s $1 $2
}

# common install for all platforms
install_base () {
    echo "install base"
    # Don't overwrite existing config (create if missing and source)
    create_and_append ". ${DOT_LOC}/config/bash/tlowry-common.bashrc" ~/.bashrc
    create_and_append ":so ${DOT_LOC}/config/vim/tlowry.vimrc" ~/.vimrc 
    create_and_append "\$include ${DOT_LOC}/config/input/inputrc" ~/.inputrc
    
    # soft link config to standard location
    make_link ${DOT_LOC}/config/vim/colors/codedark.vim ~/.vim/colors/codedark.vim
    make_link ${DOT_LOC}/config/xinitrc ~/.xinitrc
    make_link ${DOT_LOC}/config/bash_profile ~/.bash_profile
    make_link ${DOT_LOC}/config/i3/config $XDG_CONFIG_HOME/i3/config
    make_link ${DOT_LOC}/config/alacritty/alacritty.yml $XDG_CONFIG_HOME/alacritty/alacritty.yml
    make_link ${DOT_LOC}/config/mpv/mpv.conf $XDG_CONFIG_HOME/mpv/mpv.conf
    make_link ${DOT_LOC}/config/wget/wgetrc $XDG_CONFIG_HOME/wget/wgetrc
    make_link ${DOT_LOC}/config/sxhkd/sxhkdrc $XDG_CONFIG_HOME/sxhkd/sxhkdrc
    # clean way to add scripts to path (available even where $PATH is not)
    [ ! -d ~/.local/bin ] && ln -s ${DOT_LOC}/scripts ~/.local/bin 2> /dev/null
}

install_private() {
    echo "install private"    
    dec private.tgz.gpg && private/private
}

# arch/manjaro specific
install_arch() {
    echo "install arch"
    systemctl -q is-active run-media-stor.mount || sudo inst_sysd config/systemd/run-media-stor.mount
}

# rhel/centos specific
install_rhel() {
    echo "install rhel"
    # add a gnome 3 app icon to open a tabbed terminal
    ln -s ${DOT_LOC}/config/tlowry_term.desktop ${HOME}/.local/share/applications
}

## Execution begins here
[ -z $XDG_CONFIG_HOME ] && export XDG_CONFIG_HOME=~/.config 
install_base

[ -f /etc/redhat-release ] && install_rhel

distro=`uname -a | cut -d " " -f 2` ;[ $distro == "archlinux" ] && install_arch
echo $distro

[ "$1" == "home" ] && install_private
