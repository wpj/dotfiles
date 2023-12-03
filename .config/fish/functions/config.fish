function config --wraps='git --git-dir="$HOME/.cfg" --work-tree="$HOME"' --description 'git (dotfiles)'
  command git --git-dir="$HOME/.cfg" --work-tree="$HOME" $argv
end
