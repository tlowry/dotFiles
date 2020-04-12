#!/bin/sh

# find the current location of this script
DOT_LOC="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

. $DOT_LOC/scripts/util.sh

install_base () {
  # Create files if absent then append linking line if absent
  create_and_append ". ${DOT_LOC}/bash/tlowry-common.bashrc" ~/.bashrc
  create_and_append ". ${DOT_LOC}/bash/tlowry-common.profile" ~/.bash_profile
  create_and_append ":so ${DOT_LOC}/vim/tlowry.vimrc" ~/.vimrc 
  create_and_append "\$include ${DOT_LOC}/input/inputrc" ~/.inputrc
}

# create vim theming dirs and softlink
mkdir -p ~/.vim/colors/
ln -s ${DOT_LOC}/vim/colors/codedark.vim ~/.vim/colors/codedark.vim

install_private() {
  dec private.tgz.gpg && ut private.tgz && rm -rf private.tgz && private/private
}

# arch/manjaro specific
install_arch() {
    pacman -S python2 intltool strongswan networkmanager-strongswan brave mpv xl2tpd rclone tigervnc
    inst_sysd config/run-media-stor.mount
}

install_rhel() {
 # add a gnome 3 app icon to open a tabbed terminal
 append_if_missing "Exec=nohup ${DOT_LOC}/scripts/tlowry_term.sh" ${DOT_LOC}/config/tlowry_term.desktop
 ln -s ${DOT_LOC}/config/tlowry_term.desktop ${HOME}/.local/share/applications
}

if [ "$1" == "home" ]
    then
        echo "home profile"
        install_private
    else
        echo "pub profile"
fi

install_base
