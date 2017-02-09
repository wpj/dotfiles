# configuration
# =============

# oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(git z sublime git-flow)

# PATH

# default path
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin

# package manager paths
export PATH=$PATH:$HOME/{.cargo,.local}/bin

# editor (ssh/local)
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# go
export GOPATH=$HOME/code/go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

# python
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/code/python

# java
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_75.jdk/Contents/Home


# initialization
# ==============

# oh-my-zsh
source $ZSH/oh-my-zsh.sh

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# direnv
if (( $+commands[direnv] ))
then
  eval "$(direnv hook zsh)"
fi

# fuck
if (( $+commands[thefuck] ))
then
  eval $(thefuck --alias)
fi

# python
source /usr/local/bin/virtualenvwrapper.sh

# asdf
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# yarn path
if (( $+commands[yarn] ))
then
  export PATH="$PATH:`yarn global bin`"
fi

# source secrets
if [ -d "$HOME/.secret/" ]; then
	for file in $HOME/.secret/*
	do
		source "$file"
	done
fi


# aliases
# =======

alias gstat="git status"
alias gaa="git add --all"
alias open.="open ."
alias vi="nvim"
alias vi.="vi ."
alias a="atom"
alias aa="atom ."
