#!/bin/bash

# Symlink dot files into your home directory

# Each of these will be linked from ~/dotfiles/ to ~/
pathsToSymlink="zshrc vimrc gvimrc gitignore gitconfig vim tmux.conf ctags zshrc.local ipython pryrc config inputrc gdbinit"

# Print pretty colors 
keyColor='[38;5;67m' # light blue [0m 
valColor='[38;5;34m' # green      [0m 
errColor='[38;5;88m' # red        [0m 
noColor='[0m'

DOTFILESPATH="$HOME/kemist_dotfiles"
DOTFILESLOG="$HOME/dotfiles.log"

PREVPATH=$PWD

printMsg(){
    msg=$1
    echo -n "${keyColor}$msg${noColor}"
    echo $msg >> $DOTFILESLOG
}

printErr(){
    msg=$1
    echo -n "${errColor} [error]${noColor}"
    echo ""
    echo "${errColor}$msg${noColor}"
}

printOk(){
    echo "${valColor} [ok]${noColor}"
}

aptgetUpdate(){
    printMsg "Updating apt-get..."
    sudo apt-get update -y &>> $DOTFILESLOG
    if [[ $? != 0 ]] ; then
        printErr "Failed while upating apt-get"
        exit $rc
    fi
    printOk
}

aptgetInstall(){
    local packages=$@
    
    # install one at a time to see progress
    for package in $packages
    do
        printMsg "Installing $package..."
        sudo apt-get install $package -y &>> $DOTFILESLOG
        if [[ $? != 0 ]] ; then
            printErr "Failed while installing $package"
            exit $rc
        fi
        printOk
    done
}

#
# Install dependencies
# 
if [ -f /etc/redhat-release ]; then
    printMsg "Redhat detected..."
    echo "Installing vim, zsh, ctags, git and curl..."
    sleep 3
    sudo yum install vim zsh ctags git curl -y
elif [ -f /etc/lsb-release ]; then
    # Load system specific environment variables 
    . /etc/lsb-release

    if [ "$DISTRIB_ID" == "Ubuntu" ]; then
        packages="python-software-properties vim-nox zsh ctags git curl ncurses-term"

        printMsg "Ubuntu detected..." && echo ""
        sleep 1
        aptgetUpdate 
        aptgetInstall $packages        

        # we have to install this after the deps above b/c 
        # add-apt-repsoitory command relies on python-software-properites  
        printMsg "Adding up-to-date node.js repo..."
        sudo add-apt-repository ppa:chris-lea/node.js -y &>> $DOTFILESLOG
        if [[ $? != 0 ]]; then
            printErr "Couldn't add app repository"
            exit $rc
        fi
        printOk

        printMsg "Updating apt-get again..." && echo ""
        aptgetUpdate
        aptgetInstall nodejs
    fi
fi

if [ -d $DOTFILESPATH ]; then
    cd $DOTFILESPATH
    printMsg "Updating dotfiles..."
    git pull &>> $DOTFILESLOG
    if [[ $? != 0 ]]; then
        printErr "Couldn't clone into $DOTFILESPATH"
        exit $rc
    fi
else
    printMsg "Cloning github.com/kemist/dotfiles..."
    git clone git://github.com/kemist/dotfiles $DOTFILESPATH &>> ~/dotfiles.log
    if [[ $? != 0 ]]; then
        printErr "Couldn't clone into $DOTFILESPATH"
        exit $rc
    fi
fi
printOk

printMsg "Initializing & updating submodules (takes a bit)..."
cd $DOTFILESPATH
git submodule init &>> ~/dotfiles.log
git submodule update &>> ~/dotfiles.log
if [[ $? != 0 ]]; then
    printErr "Couldn't init submodules"
    exit $rc
fi
printOk

printMsg "Install autocomplete for js (tern_for_vim)..."
cd $DOTFILESPATH/vim/bundle/tern_for_vim
npm install &>> ~/dotfiles.log
if [[ $? != 0 ]]; then
    printErr "Couldn't install vim plugin tern_for_vim (autocomplete for javascript)..."
    exit $rc
fi
printOk

# json support for syntastic
printMsg "Install syntax checker for js (jshint)"
sudo npm install -g jshint &>> ~/dotfiles.log
if [[ $? != 0 ]]; then
    printErr "Couldn't install vim plugin tern_for_vim (autocomplete for javascript)..."
    exit $rc
fi
printOk

printMsg "Symlink dotfiles..." && echo ""
for pathName in $pathsToSymlink
do
    # If the file exists then skip it, otherwise symlink it a from the current directory
    if [ -h "$HOME/.$pathName" ]; then
        echo "${keyColor}$HOME/$pathName${noColor} is already symlinked" 
    elif [ -f "$HOME/.$pathName" ]; then
        echo "${keyColor}$HOME/$pathName${noColor} is a regular file" 
    else
        # .local files shouldn't be linked, they're just templates for convenience
        if [ "${pathName#*.}" == "local" ]; then
            cp $DOTFILESPATH/$pathName $HOME/.$pathName
            echo "Copied ${keyColor}$DOTFILESPATH/$pathName${noColor} to ${valColor}$HOME/.$pathName${noColor}"
        else
            ln -s $DOTFILESPATH/$pathName $HOME/.$pathName
            echo "Linked ${keyColor}$DOTFILESPATH/$pathName${noColor} to ${valColor}$HOME/.$pathName${noColor}"
        fi
    fi
done

printMsg "Configure global ignore file ~/.gitignore"
git config --global core.excludesfile '~/.gitignore'
if [[ $? != 0 ]]; then
    printErr "Couldn't configure global ignore file"
    exit $rc
fi
printOk

printMsg "Change default shell to zsh..."
sudo chsh -s `which zsh` $USER
if [[ $? != 0 ]] ; then
    printErr "Couldn't change default shell to zsh"
    exit $rc
fi
printOk

cd $PREVPATH

# auto start zsh if we're not already running it
if [ "$SHELL" != "`which zsh`" ]; then
    printMsg "Start zsh!" && echo ""
    zsh
fi

