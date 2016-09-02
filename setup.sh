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
	curl --insecure -fLo $HOME/.config/nvim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim
fi

# symlink vimrc and init.vim
mv -v $HOME/.config/nvim/init.vim $HOME/.config/nvim/init.vim.old 2> /dev/null
ln -sf $BASE/nvim/init.vim $HOME/.config/nvim/init.vim
mv -v $HOME/.vimrc $HOME/.vimrc.old 2> /dev/null
ln -sf $BASE/nvim/init.vim $HOME/.vimrc
ln -sf $HOME/.config/nvim/autoload/plug.vim  $HOME/.vim/autoload/

# install plugins
nvim +PlugInstall +qall


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
