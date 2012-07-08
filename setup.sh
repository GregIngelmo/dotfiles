#!/bin/sh

#
# Symlink dot files into the home directory
#

pathsToSymlink="zshrc vimrc gvimrc gitignore"

keyColor='[38;5;117m' # light blue [0m 
valColor='[01;33m'    # yellow     [0m 
noColor='[0m'

for fileName in $pathsToSymlink
do
    # if the file doesn't exist in the users home folder then 
    # symlink it as a hidden file from this directory
    if [ ! -f "$HOME/.$fileName" ]
    then
        echo "Linking ${keyColor}$PWD/$fileName${noColor} -> ${valColor}$HOME/.$fileName${noColor}"
        
        ln -s $PWD/$fileName $HOME/.$fileName
    fi
done

# 
# Configure global git settings for colors & gitignore
#

# git config --global core.excludesfile '~/.gitignore'
