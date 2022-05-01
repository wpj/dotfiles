set -x EDITOR nvim

set -x GOPATH $HOME/.go

set -gx VOLTA_HOME "$HOME/.volta"

set -x RIPGREP_CONFIG_PATH $HOME/.config/ripgrep/.ripgreprc

set -l HOMEBREW_BASE
if test (uname -m) = 'arm64'
	set HOMEBREW_BASE /opt/homebrew
else
	set HOMEBREW_BASE /usr/local
end

fish_add_path -g \
	$HOMEBREW_BASE/{bin,sbin} \
	$HOME/{.cargo,.local}/bin \
	$GOPATH/bin \
	(python3 -c 'import site; print(site.USER_BASE)')/bin \
	$VOLTA_HOME/bin \
	$HOME/.emacs.d/bin

if type -q brew
	fish_add_path -g \
		(brew --prefix curl)/bin

	[ -f (brew --prefix)/share/autojump/autojump.fish ]; and source (brew --prefix)/share/autojump/autojump.fish
end

if type -q pnpm
	fish_add_path -g (pnpm bin --global)
end

if type -q starship
    starship init fish | source
end

if type -q thefuck
    thefuck --alias | source
end

if type -q pyenv
    status is-login; and pyenv init --path | source
end

alias e '$EDITOR'

if type -q exa
    abbr -a l 'exa'
    abbr -a ls 'exa'
    abbr -a ll 'exa -l'
    abbr -a lll 'exa -la'
else
    abbr -a l 'ls'
    abbr -a ll 'ls -l'
    abbr -a lll 'ls -la'
end

if type -q bat
    abbr -a cat 'bat'
end

if type -q direnv
    direnv hook fish | source
end

if type -q helm
	helm completion fish | source
end

abbr -a c 'cargo'
abbr -a z 'j'
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
set -gx LDFLAGS "-L"(brew --prefix)"/opt/zlib/lib -L"(brew --prefix)"/opt/bzip2/lib"
set -gx CPPFLAGS "-I"(brew --prefix)"/opt/zlib/include -I"(brew --prefix)"/opt/bzip2/include"
