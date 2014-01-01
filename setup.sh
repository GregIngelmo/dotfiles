#!/bin/bash

# Installs dotfiles and symlinks them into your dotfiles directory
# Installs nodejs which is used by vim for javascript code completion (tern_for_vim)
# Installs python which is used by vim for python code completion (YouCompleteMe)
# Installs ruby which is used by vim for filename completion (command-t)

# Each of these will be linked from ~/dotfiles/ to ~/
pathsToSymlink="zshrc vimrc gvimrc gitignore gitconfig vim tmux.conf ctags zshrc.local ipython pryrc config inputrc gdbinit"

# Print pretty colors 
keyColor='[38;5;67m' # light blue [0m 
valColor='[38;5;34m' # green      [0m 
errColor='[38;5;124m' # red       [0m 
noColor='[0m'

DOTFILESPATH="$HOME/kemist_dotfiles"
DOTFILESLOG="$HOME/dotfiles.log"

PREVPATH=$PWD

printMsg(){
    msg=$1
    echo -n "${keyColor}$msg${noColor}"
    echo "**********************************" >> $DOTFILESLOG
    echo $msg >> $DOTFILESLOG
    echo "**********************************" >> $DOTFILESLOG
}

printErr(){
    msg=$1
    echo -n "${errColor} [error]${noColor}"
    echo ""
    echo "${errColor}$msg${noColor}"
    echo "${errColor}Check log for errors:${noColor} ${noColor}$DOTFILESLOG${noColor}"
    echo $msg >> $DOTFILESLOG
    echo "" >> $DOTFILESLOG
}

printOk(){
    echo "${valColor} [ok]${noColor}"
    echo "[ok]" >> $DOTFILESLOG
    echo "" >> $DOTFILESLOG
}

runCmd(){
    local cmd=$1
    local cmdWithLog="$cmd &>> $DOTFILESLOG"
    echo "dir: $PWD" >> $DOTFILESLOG
    echo "cmd: $cmd" >> $DOTFILESLOG
    eval $cmdWithLog
    if [[ $? != 0 ]]; then
        printErr "Failed while running: ${noColor}$cmd"
        exit $rc
    fi
    printOk
}

aptgetUpdate(){
    printMsg "Updating apt-get..."
    runCmd "sudo apt-get update -y"
}

aptgetInstall(){
    local packages=$@
    
    # install one at a time to see progress
    for package in $packages
    do
        printMsg "Installing $package..."
        runCmd "sudo apt-get install $package -y"
    done
}

printMsg "START" && echo ""

# Install dependencies
if [ -f /etc/redhat-release ]; then
    printMsg "Redhat detected..."
    exit 1
    echo "Installing vim, zsh, ctags, git and curl..."
    sudo yum install vim zsh ctags git curl -y
elif [ -f /etc/lsb-release ]; then
    # Load system specific environment variables 
    . /etc/lsb-release

    if [ "$DISTRIB_ID" == "Ubuntu" ]; then
        packages="python-software-properties vim-nox zsh ctags git curl ncurses-term"

        printMsg "Ubuntu detected" && echo ""
        aptgetUpdate 
        aptgetInstall $packages        

        # install this after the deps above b/c the
        # add-apt-respository command relies on python-software-properites  
        printMsg "Adding up-to-date node.js repo..."
        runCmd "sudo add-apt-repository ppa:chris-lea/node.js -y"

        # update apt-get again to get the latest nodejs
        aptgetUpdate
        aptgetInstall nodejs
    fi
fi

if [ -d $DOTFILESPATH ]; then
    cd $DOTFILESPATH
    printMsg "Updating dotfiles..."
    runCmd "git pull"
else
    printMsg "Cloning github.com/kemist/dotfiles..."
    runCmd "git clone git://github.com/kemist/dotfiles $DOTFILESPATH"
fi

cd $DOTFILESPATH
printMsg "Initializing submodules..."
runCmd "git submodule init"
printMsg "Updating submodules..."
runCmd "git submodule update"

cd $DOTFILESPATH/vim/bundle/tern_for_vim
printMsg "Install autocomplete for js (tern_for_vim)..."
runCmd "npm install"

printMsg "Install syntax checker for js (jshint)"
runCmd "sudo npm install -g jshint"

printMsg "Symlink dotfiles..." && echo ""
for pathName in $pathsToSymlink
do
    # if symlink or regular file then skip
    if [ -h "$HOME/.$pathName" ]; then
        echo "${keyColor}$HOME/$pathName${noColor} is already symlinked" 
        echo "$HOME/$pathName is already symlinked" >> $DOTFILESLOG 
    elif [ -f "$HOME/.$pathName" ]; then
        echo "${keyColor}$HOME/$pathName${noColor} is a regular file" 
        echo "$HOME/$pathName is a regular file" >> $DOTFILESLOG 
    else
        # .local files shouldn't be linked, they're templates for convenience
        if [ "${pathName#*.}" == "local" ]; then
            runCmd "cp $DOTFILESPATH/$pathName $HOME/.$pathName"
            echo "Copied ${keyColor}$DOTFILESPATH/$pathName${noColor} to ${valColor}$HOME/.$pathName${noColor}"
            echo "Copied $DOTFILESPATH/$pathName to $HOME/.$pathName" >> $DOTFILESLOG
        else
            runCmd "ln -s $DOTFILESPATH/$pathName $HOME/.$pathName"
            echo "Linked ${keyColor}$DOTFILESPATH/$pathName${noColor} to ${valColor}$HOME/.$pathName${noColor}"
            echo "Linked $DOTFILESPATH/$pathName to $HOME/.$pathName" >> $DOTFILESLOG
        fi
    fi
done
echo "" >> $DOTFILESLOG

printMsg "Configure global ignore file ~/.gitignore"
runCmd "git config --global core.excludesfile '~/.gitignore'"

printMsg "Change default shell to zsh..."
runCmd "sudo chsh -s `which zsh` $USER"

cd $PREVPATH

# auto start zsh if we're not running zsh
if [ "$SHELL" != "`which zsh`" ]; then
    printMsg "Start zsh!" && echo ""
    zsh
fi

