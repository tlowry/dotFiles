#!/bin/bash

# find the current location of this script
DOT_LOC="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

. $DOT_LOC/scripts/util.sh
append_if_missing "export DOT_LOC=$DOT_LOC" ~/.bashrc


# common install for all platforms
install_base () {
    echo "install base"    
    # Create files if absent then append linking line if absent
    create_and_append ". ${DOT_LOC}/bash/tlowry-common.bashrc" ~/.bashrc
    create_and_append ":so ${DOT_LOC}/vim/tlowry.vimrc" ~/.vimrc 
    create_and_append "\$include ${DOT_LOC}/input/inputrc" ~/.inputrc

    # create vim theming dirs and softlink
    mkdir -p ~/.vim/colors/
    ln -s ${DOT_LOC}/vim/colors/codedark.vim ~/.vim/colors/codedark.vim 2> /dev/null
    ln -s ${DOT_LOC}/config/xinitrc ~/.xinitrc 2> /dev/null
    ln -s ${DOT_LOC}/config/i3/config ~/.config/i3/config 2> /dev/null
    ln -s ${DOT_LOC}/config/bash_profile ~/.bash_profile 2> /dev/null
    
    # clean way to add scripts to path (availiable even where $PATH is not)
    [ ! -d ~/.local/bin ] && ln -s ${DOT_LOC}/scripts ~/.local/bin 2> /dev/null
}

install_private() {
    echo "install private"    
    dec private.tgz.gpg && private/private
}

# arch/manjaro specific
install_arch() {
    echo "arch install"
    sudo pacman -S python2 intltool strongswan networkmanager-strongswan mpv xl2tpd rclone
    sudo inst_sysd config/run-media-stor.mount
}

# rhel/centos specific
install_rhel() {
    # add a gnome 3 app icon to open a tabbed terminal
    append_if_missing "Exec=nohup ${DOT_LOC}/scripts/tlowry_term.sh" ${DOT_LOC}/config/tlowry_term.desktop
    ln -s ${DOT_LOC}/config/tlowry_term.desktop ${HOME}/.local/share/applications
}


install_base

[ -f /etc/redhat/release ] && install_rhel

distro=`uname -a | cut -d " " -f 2`
[ $distro == "archlinux" ] && install_arch

if [ "$1" == "home" ]
    then
        install_private
    else
        echo "pub profile"
fi
