#!/bin/bash

# find the current location of this script
SCRIPT_DIR=`dirname ${BASH_SOURCE[0]-$0}`
DOT_LOC=`cd $SCRIPT_DIR && pwd`

MAIN_CONFS=( 
    i3/config               alacritty/alacritty.yml 
    mpv/mpv.conf            wget/wgetrc 
    sxhkd/sxhkdrc           tmux/tmux.conf
    polybar/config          ncmpcpp/config
    cmus/rc                 cmus/main.theme
    qutebrowser/config.py   lf/lfrc               
    newsboat/config         shell/shellrc   
    openbox/rc.xml          openbox/menu.xml
    git/config              git/ignore
    bash/tlowry.bashrc      zsh/tlowry.zshrc 
    mpd/mpd.conf            vim/tlowry.vimrc        
    input/tlowry.inputrc
    wal/colorschemes/dark/supertango.json
    wal/colorschemes/dark/grey.json
)

ARCH_CONFS=(
    sxhkd/bspwm       sxhkd/sxhkdrc
    bspwm/bspwmrc     bspwm/noswallow
    bspwm/terminals
)

ul () {
    [ -L "$1" ] && unlink "$1"
}

make_link () {
    dest_dir=`dirname $2` 2> /dev/null
    [ -f $dest_dir ] || mkdir -p $dest_dir
    ul "$2"
    [ -L $2 ] || ln -s $1 $2
}

# Remove a literal line from a file (no regex)
# e.g del_lit_line "hello" hello.txt - creates hello.txt.bak
del_lit_line () {
    num=`fgrep -n "$1" "$2" | cut -d':' -f1`
    [ -z "$num" ] || sed -i.bak -e "$num"d "$2"
}

ul_bin () {
    bin_dir="$XDG_BIN_HOME"
    dots_bin="$DOT_LOC/bin"
    for file in $bin_dir/*
    do
        readlink -f "$file" | grep -q "$dots_bin" && ul "$file"
    done
}

# make user scripts available system wide
ln_bin () {
    
    bin_dir="$XDG_BIN_HOME"
    mkdir -p "$bin_dir" 2> /dev/null
    
    if [ `ls -lA $DOT_LOC/bin | wc -l` -gt 3 ]; then
        for file in $DOT_LOC/bin/*
        do
            dest_file="$bin_dir/"`basename $file`
            make_link "$file" "$dest_file"
        done

        make_link "$DOT_LOC"/bin/lib "$bin_dir"/lib
    else
        echo "no binaries to link"
    fi
}

ul_apps () {
    app_dir="$XDG_DATA_HOME/applications"
    dot_apps="$DOT_LOC/share/applications"
    for file in $app_dir/*
    do
        [ -L "$file" ] && readlink -f "$file" | grep -q "$dot_apps" && unlink "$file"
    done
}

# install apps
ln_apps () {

    app_dir="$XDG_DATA_HOME/applications"
    mkdir -p "$app_dir" 2> /dev/null

    if [ `ls -lA $DOT_LOC/share/applications | wc -l` -gt 3 ]; then
        for file in $DOT_LOC/share/applications/*
        do
            dest_file="$app_dir/"`basename $file`
            ul "$dest_file"
            make_link "$file" "$dest_file"
        done
    else
        echo "no applications to link"
    fi
}

ln_conf () {
    dest=`echo $1 | sed 's/.*\/config\///g'`
    dest=$XDG_CONFIG_HOME/$dest
    make_link "$1" "$dest"
}

ul_conf () {
    dest=`echo $1 | sed 's/.*\/config\///g'`
    dest=$XDG_CONFIG_HOME/$dest
    ul "$dest"
}

# common install for all platforms
install_base () {
    echo "install base"

    # Don't overwrite existing config (create if missing and source)
    create_and_append ". \${XDG_CONFIG_HOME:-\$HOME/.config}/bash/tlowry.bashrc" ~/.bashrc
    create_and_append ". \${XDG_CONFIG_HOME:-\$HOME/.config}/zsh/tlowry.zshrc" ~/.zshrc
    create_and_append ":so \$XDG_CONFIG_HOME/vim/tlowry.vimrc" ~/.vimrc 
    create_and_append "\$include \$XDG_CONFIG_HOME/input/tlowry.inputrc" ~/.inputrc

    # soft link config to standard location
    [ -f ~/.bash_profile ] || make_link $DOT_LOC/config/bash/bash_profile ~/.bash_profile
    [ -f ~/.zshrc ] || make_link $DOT_LOC/config/zsh/zshrc ~/.zshrc
    make_link $DOT_LOC/config/vim/colors/codedark.vim ~/.vim/colors/codedark.vim
    make_link $DOT_LOC/config/vim/colors/colors-wal.vim ~/.vim/colors/colors-wal.vim
    make_link $DOT_LOC/config/vim/autoload/pathogen.vim ~/.vim/autoload/pathogen.vim
    make_link $DOT_LOC/config/X11/Xresources ~/.config/Xresources

    # vim pathogen plugins
    mkdir -p ~/.vim/bundle
   
    # pull down any plugins stored as submodules
    git submodule update --init

    # link any installed plugins
    for dir in config/vim/bundle/*
    do
        make_link "$DOT_LOC/$dir" ~/.vim/bundle/"${dir##*/}"
    done
    
    # more straightforward directory mapped configs
    for x in ${MAIN_CONFS[@]};do
        ln_conf "$DOT_LOC/config/$x"
    done
    
    ln_bin
    ln_apps

    distro=`cat /etc/os-release` ; echo $distro | grep -q "ID_LIKE=arch" && install_arch
}

ul_vim () {
    ul ~/.vim/autoload/pathogen.vim

    # unlink any installed plugins
    for dir in ~/.vim/bundle/*
    do
        ul "$dir"
    done

    # unlink any installed colors 
    for dir in ~/.vim/colors/*
    do
        ul "$dir"
    done
}

uninstall () {
    echo "uninstall"
    del_lit_line ". \${XDG_CONFIG_HOME:-\$HOME/.config}/bash/tlowry.bashrc" ~/.bashrc
    del_lit_line ". \${XDG_CONFIG_HOME:-\$HOME/.config}/zsh/tlowry.zshrc" ~/.zshrc
    del_lit_line ":so \$XDG_CONFIG_HOME/vim/tlowry.vimrc" ~/.vimrc 
    del_lit_line "\$include \$XDG_CONFIG_HOME/input/tlowry.inputrc" ~/.inputrc
    
    ul ~/.config/Xresources

    for x in ${MAIN_CONFS[@]};do
        ul_conf "$x"
    done

    ul_bin
    ul_apps
    ul_vim

    distro=`uname -a | cut -d " " -f 2` ; echo $distro | grep -q "arch" && uninstall_arch
}

# arch/manjaro specific
install_arch() {
    echo "install arch"
    make_link $DOT_LOC/config/X11/xinitrc ~/.xinitrc

    for x in ${ARCH_CONFS[@]};do
        ln_conf "$DOT_LOC/config/$x"
    done

    xdg-mime default lf.desktop inode/directory
    xdg-mime default sxiv.desktop image/jpeg
    xdg-mime default sxiv.desktop image/png
    xdg-mime default sxiv.desktop image/gif    # todo: sxiv -a for anim
    xdg-mime default sxiv.desktop image/png
    xdg-mime default sxiv.desktop image/webp
    xdg-mime default zathura.desktop application/epub+zip
    xdg-mime default zathura.desktop application/pdf
    xdg-mime default vim.desktop text/plain
    xdg-mime default vim.desktop text/markdown
    xdg-mime default mpv.desktop audio/x-opus+ogg
    xdg-mime default calibre-ebook-viewer.desktop application/x-mobipocket-ebook
    xdg-mime default calibre-ebook-viewer.desktop application/x-mobi8-ebook

    #systemctl -q is-active stor.mount || sudo inst_sysd config/systemd/stor.mount
}

# arch/manjaro specific
uninstall_arch () {
    echo "uninstall arch"
    ul ~/.xinitrc

    # more straightforward directory mapped configs
    for x in ${arch_confs[@]};do
        ul_conf "$x"
    done
}

usage () {
    echo "use install.sh < -r optional to uninstall >"
}

while [ "$1" != "" ]; do
    case $1 in
        -p | --personal )       PERSONAL=1
                ;;
        -r | --remove )         REMOVE=1
                ;;
        -h | --help )           usage
                                exit
                ;;
        * )                     ;; 
    esac
    shift
done


. $DOT_LOC/bin/util.sh

[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME=~/.config
[ -d "$XDG_CONFIG_HOME" ] || mkdir -p "$XDG_CONFIG_HOME"

[ -z "$XDG_DATA_HOME" ] && export XDG_DATA_HOME="$HOME/.local/share"
[ -d "$XDG_DATA_HOME/applications" ] || mkdir -p "$XDG_DATA_HOME/applications"

[ -z "$XDG_CACHE_HOME" ] && export XDG_CACHE_HOME="$HOME/.cache"
[ -d "$XDG_CACHE_HOME" ] || mkdir -p "$XDG_CACHE_HOME"

[ -z "$XDG_BIN_HOME" ] && export XDG_BIN_HOME="$HOME/.local/bin"
[ -d "$XDG_BIN_HOME" ] || mkdir -p "$XDG_BIN_HOME"

if [ -z "$REMOVE" ]; then install_base ; else uninstall ; fi
