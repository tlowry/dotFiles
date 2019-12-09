append_if_missing(){
#grep -qxF $1 $2 || echo $1 >> $2
 echo $1 $2
}

thetext='source ~/scripts/tony-init.vim'
the
append_if_missing $thetext '/home/tony/.config/nvim/init.vim'



#curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
#    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
