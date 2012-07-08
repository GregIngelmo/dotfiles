#!/bin/sh

#
# Symlink dot files into the home directory
#

pathsToSymlink="zshrc vimrc gvimrc gitignore vim"

keyColor='[38;5;117m' # light blue [0m 
valColor='[01;33m'    # yellow     [0m 
noColor='[0m'

for fileName in $pathsToSymlink
do
    # If a symlink (-L) doesn't exist in the users home folder then 
    # symlink it a from the current directory
    if [ ! -L "$HOME/.$fileName" ]
    then
        echo "Linking ${keyColor}$PWD/$fileName${noColor} -> ${valColor}$HOME/.$fileName${noColor}"
        
        ln -s $PWD/$fileName $HOME/.$fileName
    fi
done

# 
# Configure global git settings for colors & gitignore
#

git config --global core.excludesfile '~/.gitignore'
