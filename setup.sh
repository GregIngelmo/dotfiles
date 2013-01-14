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
        # .local files shouldn't be linked, they're just templates for convenience
        if [ "${fileName#*.}"=="local" ]; then
            cp $PWD/$pathName $HOME/.$pathName
            echo "Copied  ${keyColor}$PWD/$pathName${noColor} to ${valColor}$HOME/.$pathName${noColor}"
        else
            ln -s $PWD/$pathName $HOME/.$pathName
            echo "Linked  ${keyColor}$PWD/$pathName${noColor} to ${valColor}$HOME/.$pathName${noColor}"
        fi
    fi
done

# Configure global git settings for colors & gitignore
git config --global core.excludesfile '~/.gitignore'
