set -x EDITOR nvim

set -x GOPATH $HOME/.go

set -gx VOLTA_HOME "$HOME/.volta"

set -gx PNPM_HOME $HOME/Library/pnpm

set -x RIPGREP_CONFIG_PATH $HOME/.config/ripgrep/ripgreprc

set -gx LG_CONFIG_FILE $HOME/.config/lazygit/config.yml

set -l HOMEBREW_BASE
if test (uname -m) = 'arm64'
	set HOMEBREW_BASE /opt/homebrew
else
	set HOMEBREW_BASE /usr/local
end

fish_add_path -g \
	$HOMEBREW_BASE/{bin,sbin} \
	$HOME/.cargo/bin \
	# pip
	$HOME/.local/bin \
	$GOPATH/bin \
	$VOLTA_HOME/bin \
	$HOME/.emacs.d/bin \
	$PNPM_HOME

if type -q brew
	fish_add_path -g (brew --prefix curl)/bin
end

if type -q zoxide
	zoxide init fish | source
end

if type -q pyenv
    status is-login; and pyenv init --path | source
end

abbr -a e $EDITOR

if type -q lsd
    abbr -a ls 'lsd'
end

if type -q bat
    abbr -a cat 'bat'
end

if type -q direnv
    direnv hook fish | source
end

abbr -a c 'cargo'
abbr -a j 'z'
abbr -a open. 'open .'
abbr -a gaa 'git add --all'
abbr -a g 'git'
abbr -a gst 'git status'
abbr -a gc 'git checkout'
abbr -a gb 'git branch'
abbr -a open. 'open .'
abbr -a vi. 'vi .'
abbr -a n 'env NNN_USE_EDITOR=1 nnn'

# For stuff not checked into git
if test -e "$HOME/.config/fish/.secret.fish"
    source ~/.config/fish/.secret.fish
end

alias ibrew 'arch -x86_64 /usr/local/bin/brew'

# Let compilers find keg-only zlib/bzip2
set -l HOMEBREW_PREFIX (brew --prefix)
set -gx LDFLAGS "-L$HOMEBREW_PREFIX/opt/zlib/lib -L$HOMEBREW_PREFIX/opt/bzip2/lib"
set -gx CPPFLAGS "-I$HOMEBREW_PREFIX/opt/zlib/include -I$HOMEBREW_PREFIX/opt/bzip2/include"

# Disable fish greeting
set -U fish_greeting
