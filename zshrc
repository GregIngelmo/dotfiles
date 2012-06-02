# ZSH Options
setopt APPEND_HISTORY               # append to history file
setopt INC_APPEND_HISTORY           # append to history file incrementally, as commands are typed in 
setopt CORRECT                      # spelling correction... >pee /foofolder ... did you mean pe?
setopt HIST_REDUCE_BLANKS           # remove useless blanks from history
setopt NO_BEEP                      # don't beep 
setopt AUTO_CD                      # cd into directories by just typing them out, ex: /foo intead of cd /foo
setopt AUTO_PUSHD                   # automatically call pushd on call to cd
setopt PUSHD_IGNORE_DUPS            # don't add dupes to the pushd stack
setopt HIST_IGNORE_ALL_DUPS         # ignore dupes
setopt EXTENDED_GLOB                # adds 3 more glob characters (#,~,^), ex: to exclude .c files ^*.c, 
setopt RM_STAR_WAIT                 # confirm before executing rm *
unsetopt CASE_GLOB                  # make globbing case insensitive by default

# Completion system (copy pasta from the internet)
autoload -U compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) )'
zstyle ':completion:*:corrections' format "- %d - (errors %e})"
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose yes
zstyle ':completion:*' list-dirs-first true                 # Separate directories from files.

# Custom keybindings  
# Hit ctrl-v at the command line and then any key to see the control code for any key
bindkey "^[[5D" backward-word	                    # ctrl-leftarrow jump backward word
bindkey "^[[5C" forward-word	                    # ctrl-rightarrow jump forward word
bindkey "^[[3~" delete-char	                        # delete key
bindkey '^R'    history-incremental-search-backward # ctrl -R search history
bindkey "^[[A"  up-line-or-search                   # up arrow go through history
bindkey "^[[B"  down-line-or-search                 # down arrow go through history

# Environment variables. printenv to print all terminal variables, unset to delete one
export HISTFILE="$HOME/.history"            # history file path
export HISTSIZE=500                         # number of history lines to keep in memory
export SAVEHIST=500                         # number of history lines to keep on disk
export LC_CTYPE=en_US.UTF-8			        # so SVN doesn't shit itself on non-ascii files

# Environment variables for colored man pages (affect less)
#export LESS_TERMCAP_DEBUG='1'
export LESS_TERMCAP_ti=$'\E[01;37m'         # white   
export LESS_TERMCAP_mb=$'[38;5;117m'      # light blue
export LESS_TERMCAP_md=$'[38;5;117m'      # light blue 
export LESS_TERMCAP_me=$'\E[0m'             # color reset
export LESS_TERMCAP_us=$'\E[01;33m'         # yellow
export LESS_TERMCAP_ue=$'\E[0m'             # color reset

# Environment variables for printing process stats if a command takes > n seconds
export REPORTTIME=1
export TIMEFMT='
> %J
  | Time:   [38;5;159m%E[0m total time, %U user time + %S kernel time
  | Disk:   [38;5;159m%F[0m major page faults (pages loaded from disk)  
  | System: [38;5;159m%P[0m max CPU used, [38;5;159m%M[0m KB max memory used'


# Useful zsh functions and modules
autoload -U colors && colors    # zsh function that loads colors w/ names into 'fg' & 'bg' arrays
autoload zcalc                  # calculator
autoload zmv                    # zsh batch file renamer ex: zmv '(*).txt' '$1.md'

# Command aliases for different systems
# Darwin means we're running on a Mac
if [[ `uname` == "Darwin" ]] then
    # if the command gls exists
    # gls is part of the GNU standard version of ls that can be installed on a Mac (brew install coreutils)
    # the 'g' prefix is added by homebrew to avoid naming collisions, gls, gcat etc...
    if (( $+commands[gls] )) ; then
        # remove date entirely for day-to-day usage
        alias ls='gls -AlFh --color --time-style="+[38;5;100m—[00m" --group-directories-first'                            
        # use English sentence style date when needed ex: [Tue, Jan 11 2011 @ 11:01 am]
        # format specifiers @ http://www.gnu.org/software/coreutils/manual/html_node/date-invocation.html#date-invocation 
        alias lsd='gls -AlFh --color --time-style="+[%a, %b %_d %Y @ %l:%M %P]" --group-directories-first'  
    else
        alias ls='ls -AlFhg'
    fi
else
    # we're prob running on linux so assume GNU ls is available
    alias ls='ls -AlFh --color --time-style="+—" --group-directories-first'                                 
    alias lsd='ls -AlFh --color --time-style="+[%a, %b %_d %Y @ %l:%M %P]" --group-directories-first'   
fi

# custom prompt
# %{ ... %} tells zsh to disregard the contained characters when calculating the length of the prompt (in order correctly position the cursor)
# Anatomy of the color code system below
local p_cwd="%{[38;5;180m%}%~%{$reset_color%}"        # current working dir
local p_ret_status="%{$fg[white]%}%?%{$reset_color%}"   # last command return code
local p_delim="%{$fg[red]%}>%{$reset_color%}"           # > as a delimiter

# Dyanmic prompt customization point, precmd gets called just before every command prompt
function precmd {
    
    # if $EUID is zero then we're running as root,
    # change the color of the username from green to red
    if [ $EUID -eq 0 ]
    then
        local USER_COLOR='[01;38;5;124m'
    else
        local USER_COLOR='[38;5;70m'
    fi
        
    local p_user_at_host="%{$USER_COLOR%}%B%n%b@%m%{$reset_color%}" 
    
    PROMPT="${p_cwd}
${p_user_at_host} [${p_ret_status}] ${p_delim} "

}

# If .zshrc.local exists include it. .zshrc.local should contain system 
# specific settings such as aliases, exports, a custom $PATH, etc...
if [[ -e "$HOME/.zshrc.local" ]] then
    source $HOME/.zshrc.local
fi

# Badass ZSH script that adds live syntax highlighting to command arguments r
# https://github.com/zsh-users/zsh-syntax-highlighting 
if [[ -e "$HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] then
    source $HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

    # enable colored braces/parens & custom patterns
    # seeing colored parens is especially great when using zcalc
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

    # change some the zsh-highlighing default colors
    ZSH_HIGHLIGHT_STYLES[globbing]='fg=blue,bold'
    ZSH_HIGHLIGHT_STYLES[path]='bold'
    ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=cyan'
    ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=cyan'
fi

