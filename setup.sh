#!/bin/sh

# Run from inside dotfiles directory

if [ ! -f "$HOME/.zshrc" ]; then
    echo "Symlinked ${PWD}/zshrc to $HOME/.zshrc"
    ln -s ${PWD}/zshrc $HOME/.zshrc
fi

