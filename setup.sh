#!/bin/sh

#
# Symlink dot files into your home directory
#

pathsToSymlink="zshrc vimrc gvimrc gitignore gitconfig vim tmux.conf"

keyColor='[38;5;110m' # light blue [0m 
valColor='[38;5;175m' # coral      [0m 
noColor='[0m'

for fileName in $pathsToSymlink
do
    # If the file exists (-a) then skip it, otherwise symlink it a from the current directory
    if [ -a "$HOME/.$fileName" ]; then
        echo "Skipped $PWD/$fileName" 
    else
        echo "Linked  ${keyColor}$PWD/$fileName${noColor} to ${valColor}$HOME/.$fileName${noColor}"
        
        ln -s $PWD/$fileName $HOME/.$fileName
    fi
done

# 
# Configure global git settings for colors & gitignore
#

git config --global core.excludesfile '~/.gitignore'
