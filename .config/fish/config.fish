set -x EDITOR nvim

set -x GOPATH $HOME/.go
set -x PATH $PATH $HOME/{.cargo,.local}/bin $GOPATH/bin

set -x PATH $PATH (python3 -c 'import site; print(site.USER_BASE)')/bin

set -x RIPGREP_CONFIG_PATH $HOME/.config/ripgrep/.ripgreprc

if type -q starship
    starship init fish | source
end

if type -q thefuck
    thefuck --alias | source
end

if type -q pyenv
	pyenv init - | source
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

[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish

if type -q direnv
    direnv hook fish | source
end

# For stuff not checked into git
if test -e "$HOME/.config/fish/.secret.fish"
    source ~/.config/fish/.secret.fish
end



# Let compilers find keg-only zlib/bzip2
set -gx LDFLAGS "-L/usr/local/opt/zlib/lib -L/usr/local/opt/bzip2/lib"
set -gx CPPFLAGS "-I/usr/local/opt/zlib/include -I/usr/local/opt/bzip2/include"
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH
