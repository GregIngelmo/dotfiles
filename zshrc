#
#       .-'\  
#    .-'  `/\    Greg's kick ass ZSH Prompt
# .-'      `/\                      
# \   ZSH   `/\                     
#  \         `/\            
#   \    _-   `/\       _.--.
#    \    _-   `/`-..--\     )  
#     \    _-   `,','  /    ,')   
#      `-_   -   ` -- ~   ,','
#       `-              ,','     
#        \,--.    ____==-~   __   __     
#         \   \_-~\         (  \,/  )
#          `_-~_.-'          \_ | _/  <-- Your mom!
#           \-~              (_/ \_)      
      
# New session summary
if [[ -o interactive ]]; then
  
    uptime=$(uptime uptime 2>/dev/null | awk '{print $3 " " $4}' | cut -d"," -f1)     
    loadAverages=$(uptime 2>/dev/null | awk '{print $10 " " $11 " " $12 }') #1 minute, 5 minute, and 15 minute load averages
    longDate=$(date "+%a, %b %_d %Y @[00m [36m%I:%M %p %Z %z")

    print "[38;5;117mHost[00m [36m$HOST[00m [38;5;117mup for[00m [36m$uptime"
    print "[38;5;117mDate[00m [36m$longDate[00m"
    print "[38;5;117mLoad[00m [36m$loadAverages[00m"

fi  #  [[ -o interactive ]]

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
setopt RM_STAR_WAIT                 # confirm before executing rm *, sanity check
unsetopt CASE_GLOB                  # make globbing case insensitive by default

# Completion system (copy pasta from the internet)
#autoload -U compinit
#compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) )'
zstyle ':completion:*:corrections' format "- %d - (errors %e})"
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose yes

# The following lines were added by compinstall

#zstyle ':completion:*' auto-description '%d'
#zstyle ':completion:*' completer _complete _ignored _correct _approximate
#zstyle ':completion:*' format '%d'
#zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
#zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=** r:|=**'
#zstyle ':completion:*' menu select=1
#zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
#zstyle :compinstall filename '/Users/greg/.zshrc'
zstyle ':completion:*' list-dirs-first true                 # Separate directories from files.

autoload -Uz compinit
compinit

# Custom keybindings  
# Hit ctrl-v at the command line and then any key to see the control code 
bindkey "^[[5D" backward-word	                    # ctrl-leftarrow jump backward word
bindkey "^[[5C" forward-word	                    # ctrl-rightarrow jump forward word
bindkey "^[[3~" delete-char                         # delete key
bindkey '^R'    history-incremental-search-backward # ctrl -R search history
bindkey "^[[A"  up-line-or-search                   # up arrow go through history
bindkey "^[[B"  down-line-or-search                 # down arrow go through history

# Environment variables. printenv to print all terminal variables, unset to delete one
export HISTFILE="$HOME/.history"            # history file path
export HISTSIZE=500                         # number of history lines to keep in memory
export SAVEHIST=500                         # number of history lines to keep on disk
export LC_CTYPE=en_US.UTF-8                 # so SVN doesn't shit itself on non-ascii files

# Environment variables for colored man pages (affect less), escape code syntax below
#export LESS_TERMCAP_DEBUG='1'
export LESS_TERMCAP_ti=$'\E[01;37m'         # white         
export LESS_TERMCAP_mb=$'[38;5;117m'      # light blue    [0m 
export LESS_TERMCAP_md=$'[38;5;117m'      # light blue    [0m 
export LESS_TERMCAP_me=$'\E[0m'             # color reset   
export LESS_TERMCAP_us=$'\E[01;33m'         # yellow        
export LESS_TERMCAP_ue=$'\E[0m'             # color reset 

# Environment variables for printing process stats if a command takes > n seconds
export REPORTTIME=1
export TIMEFMT='
> %J
  | Time:   [38;5;159m%E[0m total time, %U user time, %S kernel time
  | Disk:   [38;5;159m%F[0m major page faults (pages loaded from disk)  
  | System: [38;5;159m%P[0m max CPU used, [38;5;159m%M[0m KB max memory used'

# Useful zsh functions and modules
autoload -U colors && colors    # zsh function that loads colors w/ names into 'fg' & 'bg' arrays
autoload zcalc                  # calculator
autoload zmv                    # zsh batch file renamer ex: zmv '(*).txt' '$1.md'

grepr() {grep -iIr --color "$1" *}  # grep recursive(r), ignore case (i), ignore binary files(I). ex: grepr searchstring

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
        alias lsd='gls -AlFh --color --time-style="+[%a, %b %_d %Y @ %l:%M %P]" --group-directories-first; echo Today is `date "+%a, %b %_d %Y @ %l:%M %p"`'  
    else
        alias ls='ls -AlFhg'
    fi
else
    # assume GNU ls is available
    alias ls='ls -AlFh --color --time-style="+—" --group-directories-first'                                 
    alias lsd='ls -AlFh --color --time-style="+[%a, %b %_d %Y @ %l:%M %P]" --group-directories-first'   
fi

# custom prompt
# %{ ... %} tells zsh to disregard the contained characters when calculating the length of the prompt (in order correctly position the cursor)
local p_cwd="%{[38;5;180m%}%~%{$reset_color%}"        # current working dir
local p_ret_status="%{$fg[white]%}%?%{$reset_color%}"   # last command return code
local p_delim="%{$fg[red]%}>%{$reset_color%}"           # > as a delimiter

# Dynamic prompt customization point, precmd gets called just before every command prompt
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

# Badass ZSH script that adds live syntax highlighting to command arguments
# https://github.com/zsh-users/zsh-syntax-highlighting 
if [[ -e "$HOME/dotfiles/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] then
    source $HOME/dotfiles/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

    # enable colored braces/parens & custom patterns, great when using zcalc
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

    # change the zsh-highlighing default colors
    ZSH_HIGHLIGHT_STYLES[globbing]='fg=blue,bold'
    ZSH_HIGHLIGHT_STYLES[path]='bold'
    ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=cyan'
    ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=cyan'
fi

# ESC '  Quote the current line; that is, put a `'' character at the beginning and the end, and convert all `'' characters to `'\'''  
# ^ a    Move to beginnging of line
# ^ e    Move to end of line
# ^ XF   Move to next typed character
# ESC U  Uppercase a word
# ESC c  Uppercase a character
# ^ l    Clear screen
# ^ @    Set Mark

# The 256 color escape code syntax
# The #'s noted are adjustable, everything else must remain untouched
# Once a color is set it must be unset using ^[[00
# http://lucentbeing.com/blog/that-256-color-thing/
#
# print '[01;38;05;50;48;05;100m poop [00'  don't forget the m...
#        |/ |/       |/       |/___________ dark yellow background color (100)
#        |  |        |_____________________ aqua foreground color (50)
#        |  |______________________________ bold text attribute (01) 
#        |_________________________________ hit ctrl-v then esc to start escape sequence*
#
# * In most cases the escape sequence can also be written as \E or \033, but you must
#   enable backslash escapes for that to work.
#
# Shortcut to change just the foreground to aqua (50)
# print '[38;05;50m poop [00 '
# 
# text attributes
#   0=RESET     1=BOLD              4=underline 24=not underline, 
#   5=blinking  25=notblinking      7=inverse   27=notinverse    
#   22=not bold
# 
# colors
#   1-255    
