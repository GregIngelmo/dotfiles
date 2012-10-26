#Greg's dotfiles 

These are my dotfiles. There are many like them, but these are mine.

## Required

* **[Zsh ](http://www.zsh.org/)** - An awesome shell 
* **[Ctags](http://ctags.sourceforge.net/)** - Source code tokenizer, slicer and dicer
* **[Homebrew](http://mxcl.github.com/homebrew/)** - Package manager for OS X, sorry Macports :(
* **[GNU coreutils](http://www.gnu.org/software/coreutils/)** - The latest file and text manipulation utilities. ls, cat, etc…



## Recommended

* **[iTerm2](http://www.iterm2.com)** -  The terminal of terminals
* **[Inconsolata-dz](http://media.nodnod.net/Inconsolata-dz.otf.zip)** & **[Inconsolata-dz Powerline](https://gist.github.com/raw/1595572/51bdd743cc1cc551c49457fe1503061b9404183f/Inconsolata-dz-Powerline.otf)** - A nice monospaced font based on Consolas



## Install dependencies

#### OS X
	
Download and install [Xcode](https://itunes.apple.com/us/app/xcode/id497799835?ls=1&mt=12)  
Download and install [Homebrew](http://mxcl.github.com/homebrew/)

	brew install coreutils zsh ctags git
	brew tap homebrew/dupes
	brew install grep

Download and install [Inconsolata-dz](http://media.nodnod.net/Inconsolata-dz.otf.zip) & [Inconsolata-dz Powerline](https://gist.github.com/raw/1595572/51bdd743cc1cc551c49457fe1503061b9404183f/Inconsolata-dz-Powerline.otf)  
Download and Install [iTerm2](http://www.iterm2.com/#/section/home)

#### Ubuntu

	sudo apt-get install zsh ctags git    

#### CentOS

	sudo yum install zsh ctags git -y


## Configure dotfiles

Run `setup.sh`. It'll symlink the files to your home directory, it won't overwrite anything. 

	chsh -s `which zsh`
	git clone --recursive http://github.com/kemist/dotfiles
	cd dotfiles
	./setup.sh
	cd..
	zsh

...or be a *manly man* and use a one-liner

	chsh -s `which zsh` && git clone --recursive http://github.com/kemist/dotfiles && cd dotfiles && ./setup.sh




## ZSH

#### Command syntax highlighting

![fish](http://23.21.137.87/static//fish.png)

#### Long running command summary

![time](http://23.21.137.87/static//time.png)

#### No dates by default, baller ls_colors
	
![ls](http://23.21.137.87/static//ls.png)	

#### English sentence style dates when needed
	
![ls](http://23.21.137.87/static//lsd.png)

#### Running as root reminder

![root](http://23.21.137.87/static//root.png)

#### New session summary 

![root](http://23.21.137.87/static//newshell.png)

#### Fancier `less` status bar info

![root](http://23.21.137.87/static//less.png)

#### Recent directory tracking (better than pushd/popd)

![foo](http://23.21.137.87/static//cdr.png)

#### And of course... Tetris

![tetris](http://23.21.137.87/static//tetris.png)


## Vim
* **[Tagbar](http://majutsushi.github.com/tagbar/)** - Just like the class view in XCode/Visual Studio
* **[Powerline](https://github.com/Lokaltog/vim-powerline)** - Everyone stopped writing status bars after this one
* **[NERD tree](https://github.com/scrooloose/nerdtree)** - The 700bhp muscle car of Treeviews
* **[Bufexplorer](http://www.vim.org/scripts/script.php?script_id=42)** - Quickly switch between open files
* **[Easy Motion](https://github.com/Lokaltog/vim-easymotion#readme)** - Quickly jump around inside a file
* **[Conque Term](https://code.google.com/p/conque/)** - Interactive terminal right inside vim. Why? Because you can.

    

