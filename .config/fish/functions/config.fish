function config --description 'git (dotfiles)'
  command git --git-dir="$HOME/.cfg" --work-tree="$HOME" $argv
end
