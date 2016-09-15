#!/bin/sh

BASE=$(pwd)

ln -s $BASE/.secret/ $HOME/.secret


# vim/nvim
# ========

# create dirs
mkdir -p ~/.config/nvim/autoload
mkdir -p ~/.vim/autoload

# autoload vim-plug
if [ ! -f $HOME/.config/nvim/autoload/plug.vim ]; then
	echo "Installing vim-plug"
	curl --insecure -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim
fi

# vimrc
mv -v ~/.vimrc ~/.vimrc.old 2> /dev/null
ln -sf $BASE/vim/vimrc ~/.vimrc

# nvim
ln -sf $BASE/vim/vimrc ~/.config/nvim/init.vim
ln -sf ~/.vim/autoload/plug.vim ~/.config/nvim/autoload/

# install plugins
vim +PlugInstall +qall


# zsh
# ===

# symlink zshrc
mv -v $HOME/.zshrc $HOME/.zshrc.old 2> /dev/null
ln -sf $BASE/zsh/zshrc $HOME/.zshrc

# git
# ===

# symlink gitconfig
mv -v $HOME/.gitconfig $HOME/.gitconfig.old 2> /dev/null
ln -sf $BASE/git/gitconfig $HOME/.gitconfig
