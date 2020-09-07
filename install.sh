#!/bin/bash
make_link () {
    dest_dir=`dirname $2` 2> /dev/null
    [ -f $dest_dir ] || mkdir -p $dest_dir
    [ -L $2 ] && unlink $2
    [ -L $2 ] || ln -s $1 $2
}

# Remove a literal line from a file (no regex)
# e.g del_lit_line "hello" hello.txt - creates hello.txt.bak
del_lit_line () {
    num=`fgrep -n "$1" "$2" | cut -d':' -f1`
    [ -z "$num" ] || sed -i.bak -e "$num"d "$2"
}

ul_scripts () {
    bin_dir="$HOME/.local/bin"
    dots_bin="${DOT_LOC}/scripts"
    for file in $bin_dir/*
    do
        readlink -f "$file" | grep -q "$dots_bin" && unlink "$file"
    done
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

ul_apps () {
    app_dir="$XDG_DATA_HOME/applications"
    dot_apps="${DOT_LOC}/local/share/applications"
    for file in $app_dir/*
    do
        readlink -f "$file" | grep -q "$dot_apps" && unlink "$file"
    done
}

# install apps
ln_apps () {
    app_dir="$XDG_DATA_HOME/applications"
    mkdir -p "$app_dir" 2> /dev/null
    for file in ${DOT_LOC}/local/share/applications/*
    do
        dest_file="$app_dir/"`basename $file`
        make_link $file $dest_file
    done
}

# common install for all platforms
install_base () {
    echo "install base"

    append_if_missing "export DOT_LOC=$DOT_LOC" ~/.bashrc
    # Don't overwrite existing config (create if missing and source)
    create_and_append ". ${DOT_LOC}/config/bash/tlowry-common.bashrc" ~/.bashrc
    create_and_append ":so ${DOT_LOC}/config/vim/tlowry.vimrc" ~/.vimrc 
    create_and_append "\$include ${DOT_LOC}/config/input/inputrc" ~/.inputrc
    
    # soft link config to standard location
    make_link ${DOT_LOC}/config/vim/colors/codedark.vim ~/.vim/colors/codedark.vim
    make_link ${DOT_LOC}/config/vim/colors/colors-wal.vim ~/.vim/colors/colors-wal.vim
    [ -f ~/.bash_profile ] || make_link ${DOT_LOC}/config/bash_profile ~/.bash_profile
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
    make_link ${DOT_LOC}/config/openbox/rc.xml $XDG_CONFIG_HOME/openbox/rc.xml
    make_link ${DOT_LOC}/config/openbox/menu.xml $XDG_CONFIG_HOME/openbox/menu.xml
    
    ln_scripts
    ln_apps

    distro=`uname -a | cut -d " " -f 2` ;[ $distro == "archlinux" ] && install_arch

    [ "$1" == "home" ] && install_private
}

uninstall() {
    echo "uninstall"
    del_lit_line ". ${DOT_LOC}/config/bash/tlowry-common.bashrc" ~/.bashrc
    del_lit_line ":so ${DOT_LOC}/config/vim/tlowry.vimrc" ~/.vimrc 
    del_lit_line "\$include ${DOT_LOC}/config/input/inputrc" ~/.inputrc
    del_lit_line "export DOT_LOC=$DOT_LOC" ~/.bashrc
    ul_scripts
    ul_apps
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

usage() {
    echo "use install.sh < -r optional to uninstall >"
}

while [ "$1" != "" ]; do
    case $1 in
        -r | --remove )         REMOVE=1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     ;; 
    esac
    shift
done

# find the current location of this script
DOT_LOC="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
. $DOT_LOC/scripts/util.sh

[ -z $XDG_CONFIG_HOME ] && export XDG_CONFIG_HOME=~/.config 
if [ -z "$REMOVE" ]; then install_base; else uninstall ; fi
