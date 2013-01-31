
Greg's dotfiles 
===============

These are my dotfiles. There are many like them, but these are mine.

Install
-------
#### On OS X

Recommended
* **[iTerm2](http://www.iterm2.com)** - Better terminal than Terminal
* **[Inconsolata-dz](http://media.nodnod.net/Inconsolata-dz.otf.zip)** & **[Inconsolata-dz Powerline](https://gist.github.com/raw/1595572/51bdd743cc1cc551c49457fe1503061b9404183f/Inconsolata-dz-Powerline.otf)** - Monospaced font based on Microsoft Consolas

	
Required
* **[Xcode](https://itunes.apple.com/us/app/xcode/id497799835?ls=1&mt=12)**
* **[Homebrew](http://mxcl.github.com/homebrew/)** - OS X package manager
* **[Zsh](http://www.zsh.org/)** - The best shell ever
* **[Ctags](http://ctags.sourceforge.net/)** - Source code tokenizer, slicer and dicer for vim
* **[GNU coreutils](http://www.gnu.org/software/coreutils/)** - The GNU versions of standard file/text manipulation tools (ls, cat, etc). 

Run

	brew install coreutils zsh ctags git
	brew tap homebrew/dupes
	brew install grep less

#### On Ubuntu

**ncurses-term** will enable our 256 color terminal

	sudo apt-get install zsh ctags git ncurses-term

#### On Cent
	sudo yum install zsh ctags git -y

Configure
---------

Run `setup.sh`. It will symlink the files into your home directory, don't worry it won't overwrite anything.

	cd ~/
    chsh -s `which zsh`
	git clone --recursive http://github.com/kemist/dotfiles
	cd dotfiles
	./setup.sh
	cd..
	zsh

Or you can be a *manly man* and use a one-liner

	cd ~/ && chsh -s `which zsh` && git clone --recursive http://github.com/kemist/dotfiles && cd dotfiles && ./setup.sh && cd .. && zsh

Terminal features
-----------------

#### Syntax highlighting

![fish](http://23.21.137.87/static/fish.png)

#### Long running command summary

![time](http://23.21.137.87/static/time.png)

#### Low contrast `ls` colors, no dates by default
	
![ls](http://23.21.137.87/static/ls.png)	

#### English sentence style dates when you want them
	
![ls](http://23.21.137.87/static/lsd.png)

#### Root reminder

![root](http://23.21.137.87/static/root.png)

#### New session summary 

![root](http://23.21.137.87/static/newshell.png)

#### Fancier `less` status bar

![statusbar](http://23.21.137.87/static//lessstatusbar.png)

#### `less` colors

![less](http://23.21.137.87/static/lesscolors.png)

#### Recent directory tracking

![cdr](http://23.21.137.87/static//cdr.png)

#### Tetris

![tetris](http://23.21.137.87/static//tetris.png)

Vim
---

* **[Tagbar](http://majutsushi.github.com/tagbar/)** - Class view
* **[Powerline](https://github.com/Lokaltog/vim-powerline)** - Everyone stopped writing status bars after this one
* **[NERD tree](https://github.com/scrooloose/nerdtree)** - The 700bhp muscle car of Treeviews
* **[Bufexplorer](http://www.vim.org/scripts/script.php?script_id=42)** - Quickly switch between open files
* **[Easy Motion](https://github.com/Lokaltog/vim-easymotion#readme)** - Quickly jump around inside a file
* **[Conque Term](https://code.google.com/p/conque/)** - Interactive terminal right inside vim… Because you can.

    
Credit
------

http://nvie.com/posts/how-i-boosted-my-vim/  
https://github.com/moolicious/dotfiles
