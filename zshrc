# configuration
# =============

# zplug

if [[ ! -d ~/.zplug ]]
then
  git clone https://github.com/zplug/zplug $HOME/.zplug
fi

export ZPLUG_HOME=$HOME/.zplug
source $ZPLUG_HOME/init.zsh

zplug "mafredri/zsh-async"
zplug "sindresorhus/pure", use:pure.zsh, as:theme
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/sublime", from:oh-my-zsh
zplug "plugins/common-aliases", from:oh-my-zsh
zplug "lib/history", from:oh-my-zsh
zplug "zsh-users/zsh-completions", defer:2
zplug "zsh-users/zsh-autosuggestions", defer:2
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:2

zplug load

# bind up and down arrow keys to history search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

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

# fasd
if (( $+commands[fasd] ))
then
  eval "$(fasd --init auto)"
fi

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
export VIRTUAL_ENV_DISABLE_PROMPT=1
source /usr/local/bin/virtualenvwrapper.sh
workon default

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
