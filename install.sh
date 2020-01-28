. scripts/util.sh

#curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
#    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

LOC=$(pwd)

# Create files if absent then append linking line if absent
create_and_append ". ${LOC}/bash/tlowry-common.bashrc" ~/.bashrc
create_and_append ". ${LOC}/bash/tlowry-common.profile" ~/.bash_profile
create_and_append ":so ${LOC}/vim/tlowry.vimrc" ~/.vimrc 

create_and_append "set editing-mode vi" ~/.inputrc

# create vim theming dirs and softlink
mkdir -p ~/.vim/colors/
ln -s ${LOC}/vim/colors/codedark.vim ~/.vim/colors/codedark.vim
