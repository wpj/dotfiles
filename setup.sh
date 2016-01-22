#!/bin/sh

BASE=$(pwd)

ln -s $BASE/.secret/ $HOME/.secret

# vim/nvim
# ========

# create dirs
mkdir -p ~/.config/nvim/autoload
mkdir -p ~/.vim/autoload

# autoload vim-plug
curl --insecure -fLo $HOME/.config/nvim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim

# symlink vimrc and init.vim
ln -sf $BASE/nvim/init.vim $HOME/.config/nvim/init.vim
mv -v ~/.vimrc ~/.vimrc.old 2> /dev/null
ln -sf $BASE/nvim/init.vim $HOME/.vimrc
ln -sf $HOME/.config/nvim/autoload/plug.vim  $HOME/.vim/autoload/

# install plugins
nvim +PlugInstall +qall
