. scripts/util.sh

#curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
#    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# find the current location of this script
LOC="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Create files if absent then append linking line if absent
create_and_append ". ${LOC}/bash/tlowry-common.bashrc" ~/.bashrc
create_and_append ". ${LOC}/bash/tlowry-common.profile" ~/.bash_profile
create_and_append ":so ${LOC}/vim/tlowry.vimrc" ~/.vimrc 
create_and_append "\$include ${LOC}/input/inputrc" ~/.inputrc

# create vim theming dirs and softlink
mkdir -p ~/.vim/colors/
ln -s ${LOC}/vim/colors/codedark.vim ~/.vim/colors/codedark.vim

install_rclone() {
    # rclone conf
    mkdir -p ~/.config/rclone/
    dec ${LOC}/config/rclone/rclone.conf.gpg && mv rclone.conf ${LOC}/config/rclone
    ln -s ${LOC}/.config/rclone/rclone.conf ~/.config/rclone/rclone.conf
}

if [ "$1" == "home" ]
    then
        echo "home profile"
        install_rclone
    else
        echo "pub profile"
fi

# add a gnome 3 app icon to open a tabbed terminal
append_if_missing "Exec=nohup ${LOC}/scripts/tlowry_term.sh" ${LOC}/config/tlowry_term.desktop
ln -s ${LOC}/config/tlowry_term.desktop ${HOME}/.local/share/applications
