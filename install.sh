#  Append text to the end of a file if not already present
append_if_missing(){
 grep -qxF "$1" $2 || echo "$1" >> $2
}

# Create files only if not extant and append contents if not already present
create_and_append(){
 touch -c $2
 append_if_missing "$1" $2
}

#curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
#    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Some config files are sourced from existing ones and some softlinked

create_and_append ". ~/dotFiles/bash/tlowry-common-bashrc" ~/.bashrc
create_and_append ". ~/dotFiles/bash/tlowry-common.profile" ~/.bash_profile
create_and_append ":so ~/dotFiles/vim/tlowry.vimrc" ~/.vimrc 
ln -s ~/dotFiles/vim/colors/codedark.vim ~/.vim/colors/codedark.vim

#ln -s ~/dotFiles/config/nvim ~/.config/nvim
