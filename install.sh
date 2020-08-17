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

# make user scripts available system wide
ln_scripts () {
    
    bin_dir="$HOME/.local/bin"
    mkdir -p "$bin_dir" 2> /dev/null
    for file in ${DOT_LOC}/scripts/*
    do
        dest_file="$bin_dir/"`basename $file`
        make_link $file $dest_file
    done

    make_link "${DOT_LOC}"/scripts/lib "$bin_dir"/lib
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
    make_link ${DOT_LOC}/config/vim/colors/colors-wal.vim ~/.vim/colors/colors-wal.vim
    make_link ${DOT_LOC}/config/bash_profile ~/.bash_profile
    make_link ${DOT_LOC}/config/i3/config $XDG_CONFIG_HOME/i3/config
    make_link ${DOT_LOC}/config/alacritty/alacritty.yml $XDG_CONFIG_HOME/alacritty/alacritty.yml
    make_link ${DOT_LOC}/config/mpv/mpv.conf $XDG_CONFIG_HOME/mpv/mpv.conf
    make_link ${DOT_LOC}/config/wget/wgetrc $XDG_CONFIG_HOME/wget/wgetrc
    make_link ${DOT_LOC}/config/sxhkd/sxhkdrc $XDG_CONFIG_HOME/sxhkd/sxhkdrc
    make_link ${DOT_LOC}/config/tmux/tmux.conf $XDG_CONFIG_HOME/tmux/tmux.conf
    make_link ${DOT_LOC}/config/polybar/config $XDG_CONFIG_HOME/polybar/config
    make_link ${DOT_LOC}/config/X11/Xresources $XDG_CONFIG_HOME/Xresources
    make_link ${DOT_LOC}/config/wal/colorschemes/dark/supertango.json $XDG_CONFIG_HOME/wal/colorschemes/dark/supertango.json
    make_link ${DOT_LOC}/config/wal/colorschemes/dark/grey.json $XDG_CONFIG_HOME/wal/colorschemes/dark/grey.json

    make_link ${DOT_LOC}/config/cmus/rc $XDG_CONFIG_HOME/cmus/rc
    make_link ${DOT_LOC}/config/cmus/main.theme $XDG_CONFIG_HOME/cmus/main.theme
    make_link ${DOT_LOC}/config/conky/conky.conf $XDG_CONFIG_HOME/conky/conky.conf
    make_link ${DOT_LOC}/config/qutebrowser/config.py $XDG_CONFIG_HOME/qutebrowser/config.py
    make_link ${DOT_LOC}/config/lf/lfrc $XDG_CONFIG_HOME/lf/lfrc
    make_link ${DOT_LOC}/config/newsboat/config $XDG_CONFIG_HOME/newsboat/config
    make_link ${DOT_LOC}/config/jwm/jwmrc $XDG_CONFIG_HOME/jwm/jwmrc
    make_link ${DOT_LOC}/config/openbox/rc.xml $XDG_CONFIG_HOME/openbox/rc.xml
    make_link ${DOT_LOC}/config/openbox/menu.xml $XDG_CONFIG_HOME/openbox/menu.xml
    
    ln_scripts
}

install_private() {
    echo "install private"    
    dec private.tgz.gpg && private/private
}

# arch/manjaro specific
install_arch() {
    echo "install arch"
    systemctl -q is-active run-media-stor.mount || sudo inst_sysd config/systemd/run-media-stor.mount
    make_link ${DOT_LOC}/config/xinitrc ~/.xinitrc
    make_link ${DOT_LOC}/config/bspwm/bspwmrc $XDG_CONFIG_HOME/bspwm/bspwmrc
    make_link ${DOT_LOC}/config/bspwm/bspswallow $XDG_CONFIG_HOME/bspwm/bspswallow
    make_link ${DOT_LOC}/local/share/applications $XDG_DATA_HOME/applications

	xdg-mime default sxiv.desktop image/jpeg
	xdg-mime default sxiv.desktop image/png
	xdg-mime default sxiv.desktop image/gif	# TODO: sxiv -a for anim
	xdg-mime default sxiv.desktop image/png
	xdg-mime default zathura.desktop application/epub+zip
	xdg-mime default zathura.desktop application/pdf
    xdg-mime default vim.desktop text/plain

	xdg-mime default calibre-ebook-viewer.desktop application/x-mobipocket-ebook
	xdg-mime default calibre-ebook-viewer.desktop application/x-mobi8-ebook 
}

# rhel/centos specific
install_rhel() {
    echo "install rhel"
    # add a gnome 3 app icon to open a tabbed terminal
    ln -s ${DOT_LOC}/config/tlowry_term.desktop ${HOME}/.local/share/applications
}

[ -z $XDG_CONFIG_HOME ] && export XDG_CONFIG_HOME=~/.config 
install_base

[ -f /etc/redhat-release ] && install_rhel

distro=`uname -a | cut -d " " -f 2` ;[ $distro == "archlinux" ] && install_arch
echo $distro

[ "$1" == "home" ] && install_private
