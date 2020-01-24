. scripts/util.sh

#curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
#    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Some config files are sourced from existing ones and some softlinked

create_and_append ". ~/dotFiles/bash/tlowry-common.bashrc" ~/.bashrc
create_and_append ". ~/dotFiles/bash/tlowry-common.profile" ~/.bash_profile
create_and_append ":so ~/dotFiles/vim/tlowry.vimrc" ~/.vimrc 
mkdir -p ~/.vim/colors/
ln -s ~/dotFiles/vim/colors/codedark.vim ~/.vim/colors/codedark.vim

#ln -s ~/dotFiles/config/nvim ~/.config/nvim
