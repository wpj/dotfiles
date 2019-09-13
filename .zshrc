export PS1='-> '

# editor (ssh/local)
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

export GOPATH=$HOME/.go
export PATH=$PATH:$HOME/.cargo/bin:$HOME/.local/bin:$GOPATH/bin

# python
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/code/python
export VIRTUALENVWRAPPER_PYTHON=`which python3`

# java
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_75.jdk/Contents/Home

# rust
export RUST_SRC_PATH=${HOME}/.rustup/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src


# python
export VIRTUAL_ENV_DISABLE_PROMPT=1
[ -f /usr/local/bin/virtualenvwrapper.sh ] && source /usr/local/bin/virtualenvwrapper.sh

# yarn path
if (( $+commands[yarn] ))
then
  export PATH=$PATH:`yarn global bin`
fi
