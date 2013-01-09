#!/bin/sh

#
# Symlink dot files into your home directory
#

pathsToSymlink="zshrc vimrc gvimrc gitignore gitconfig vim tmux.conf ctags zshrc.local"

keyColor='[38;5;110m' # light blue [0m 
valColor='[38;5;175m' # coral      [0m 
noColor='[0m'

for pathName in $pathsToSymlink
do
    # If the file exists then skip it, otherwise symlink it a from the current directory
    if [ -e "$HOME/.$pathName" ]; then
        echo "File exists, skipping $PWD/$pathName" 
    else
        echo "Linked  ${keyColor}$PWD/$pathName${noColor} to ${valColor}$HOME/.$pathName${noColor}"
        
        ln -s $PWD/$pathName $HOME/.$pathName
    fi
done

# Configure global git settings for colors & gitignore
git config --global core.excludesfile '~/.gitignore'
