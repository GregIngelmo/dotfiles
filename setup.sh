#!/bin/bash

#
# Symlink dot files into your home directory
# This script is meant to be run from a users home folder
#

# autocomplete for js
# cd vim/bundle/tern_for_vim
# npm install

# json support for syntastic
# npm install -g jslint

# js support for syntastic
# npm install -g jshint

pathsToSymlink="zshrc vimrc gvimrc gitignore gitconfig vim tmux.conf ctags zshrc.local ipython pryrc config inputrc gdbinit"

keyColor='[38;5;110m' # light blue [0m 
valColor='[38;5;175m' # coral      [0m 
noColor='[0m'

if [ -f /etc/redhat-release ]; then
    echo "Installing vim, zsh, ctags, and git"
    sudo yum install vim zsh ctags git -y
elif [ -f /etc/lsb-release ]; then
    # Load the variables
    . /etc/lsb-release

    if [ "$DISTRIB_ID" == "Ubuntu" ]; then
        echo "Installing vim, zsh, ctags, git, and ncurses-term"
        sudo apt-get update
        sudo apt-get install zsh ctags git ncurses-term vim -y
    fi
fi

if [[ $? != 0 ]] ; then
    echo "Can't install dependencies..."
    exit $rc
fi

git clone --recursive git://github.com/kemist/dotfiles

if [[ $? != 0 ]] ; then
    echo "Can't clone dotfiles repo..."
    exit $rc
fi
cd dotfiles

for pathName in $pathsToSymlink
do
    # If the file exists then skip it, otherwise symlink it a from the current directory
    if [ -e "$HOME/.$pathName" ]; then
        echo "File exists, skipping $PWD/$pathName" 
    else
        # .local files shouldn't be linked, they're just templates for convenience
        if [ "${pathName#*.}" == "local" ]; then
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

cd ..
zsh
