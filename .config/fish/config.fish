if type -q starship
  eval (starship init fish)
end

if type -q thefuck
  thefuck --alias | source
end

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