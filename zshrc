#
# A bash smashin                      _///_,  
# Zsh console                        / ` ' '>
#                                   ఠ'  __/_'>    
#                                  /  _/  )_\'>i    
#                                 (^(_/   /_/\_>   
#                               ,/|   ____/_/_/_/    Zsh
#                             ,//('  /,---, _/ / 
#                           ( ( ')  ""  /_/_/_/
#                         -)) )) (     /_(_(_(_                 \
#                       ,/,'//( (     (   \_\_\\_               )\
#                     ,( ( ((, )       \'__\_\_\_\__            )0\
#                    ~/  )` ) /        //____|___\__)           )_/2
#                  _-~//( )/ )         |  _  \'___'_(           /'4
#                  '( ')/ ,(/           \_ (-'\'___'_\      __,'_'
#                   '                 __) \  \\___(_   __/.__,'
#            .-"--.o,o             ,((,-,__\  '", __\_/. __,'
#   Bash    '->>>--'﹏          ---------------'"./_._._-'--
#             `  `         -----------------------------------
#-----------------------------------------------------------------       
# Original (less angry) Dragon 
# http://www.chris.com/ascii/index.php?art=creatures/dragons

# new session summary
# if [[ -o interactive ]]; then
#   
#     local key_color='[38;5;117m'
#     local value_color='[38;5;189m'
#
#     uptime=$(uptime 2>/dev/null | awk '{print $3 " " $4}' | cut -d"," -f1)     
#     loadAverages=$(uptime 2>/dev/null | awk '{print $(NF-2) " " $(NF-1) " " $(NF) }')
#     longDate=$(date "+%a, %b %_d %Y @[00m ${value_color}%I:%M %p (%Z %z)")
#     
#     print "${key_color}Host[00m ${value_color}$HOST[00m ${key_color}up for[00m ${value_color}$uptime"
#     print "${key_color}Date[00m ${value_color}$longDate[00m"
#     print "${key_color}Load[00m ${value_color}$loadAverages[00m"
# fi

# zsh Options
setopt APPEND_HISTORY               # append to history file
setopt INC_APPEND_HISTORY           # append to history file incrementally, as commands are typed in 
setopt CORRECT                      # spelling correction... >pee /foofolder ... did you mean pe?
setopt HIST_REDUCE_BLANKS           # remove useless blanks from history
setopt NO_BEEP                      # don't beep 
setopt AUTO_CD                      # cd into directories by just typing them out, ex: /foo instead of cd /foo
setopt AUTO_PUSHD                   # automatically call pushd on call to cd
setopt PUSHD_IGNORE_DUPS            # don't add dupes to the pushd stack
setopt HIST_IGNORE_ALL_DUPS         # ignore dupes
setopt EXTENDED_GLOB                # adds 3 more glob characters (#,~,^), ex: to exclude .c files ^*.c, 
setopt RM_STAR_WAIT                 # confirm before executing rm *, sanity check
unsetopt CASE_GLOB                  # make globbing case insensitive by default

# completion system
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) )'
zstyle ':completion:*:corrections' format "- %d - (errors %e})"
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose yes
zstyle ':completion:*' list-dirs-first true                 # separate directories from files.
zstyle ':vcs_info:*' enable git cvs svn                     # only enable version control info for the 3 big ones
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

autoload -Uz compinit && compinit
autoload -U is-at-least

# use cdr, a zsh native function that replaces pushd/popd
# cdr <tab> to see an MRU of directories <3
if is-at-least 4.3.11; then
    autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
    add-zsh-hook chpwd chpwd_recent_dirs
    zstyle ':chpwd:*' recent-dirs-default true
    zstyle ':completion:*:*:cdr:*:*' menu selection # enable tab completion
fi

# iTerm escape sequences that allow us to change the color & shape of the cursor 
# smart cursor must be turned OFF (http://www.iterm2.com/#/section/documentation/escape_codes)
if (( ${+ITERM_PROFILE} )); then
    echo -e -n "\e]Pm000000\e\\"   # black text
    echo -e -n "\e]Plffaf00\e\\"   # orange cursor
fi

# Custom keybindings. These enable ctrl-arrow, ctrl-backspace, & ctrl-del
# Hit ctrl-v at the command line and then any key to see the control code 
bindkey "^[[1;5D" backward-word	                    # ctrl-leftarrow jump backward word for iTerm
bindkey "^[[1;5C" forward-word	                    # ctrl-rightarrow jump forward word for iTerm
bindkey "^[[5D" backward-word	                    # ctrl-leftarrow jump backward word for Terminal
bindkey "^[[5C" forward-word	                    # ctrl-rightarrow jump forward word for Terminal
bindkey "^A"    beginning-of-line                   # ctrl-a in tmux 
bindkey "^[[1~" beginning-of-line                   # home key in tmux 
bindkey "^E"    end-of-line                         # ctrl-e in tmux 
bindkey "^[[4~" end-of-line                         # end key in tmux
bindkey "^[[3~" delete-char                         # delete key
bindkey '^R'    history-incremental-search-backward # ctrl-r search history
bindkey "^[[A"  up-line-or-search                   # up through history
bindkey "^[[B"  down-line-or-search                 # down through history
bindkey "\ed"   delete-word                         # esc-d is mapped to ctrl-del in iTerm
bindkey "\ez"   backward-delete-word                # esc-z is mapped to ctrl-backspace in iTerm

# Environment variables. Use printenv to print all terminal variables, unset to delete one
export EDITOR=vim
export HISTFILE="$HOME/.history"            # history file path
export HISTSIZE=20000                       # number of history lines to keep in memory
export SAVEHIST=20000                       # number of history lines to keep on disk
export LC_CTYPE=en_US.UTF-8                 # so SVN doesn't shit itself on non-ascii files
export GREP_OPTIONS='--color'               # always show color with grep
export GREP_COLORS='fn=38;5;67'
export WORDCHARS='*?_[]~&;!#$%^(){}'        # Remove slash, period, angle brackets, dash and equal from valid word characters
                                            # This allows delete-word (ctrl-w) to delete a piece of a path,
                                            # and ctrl-arrow to jumps between parts of a path

# custom less behaviors. 
# X prevents less from clearing screen on quit
# -P customizes prompt to ex: .zshrc lines 1-47/228 20%
# -R print control chacters, allows colors to flow through less
export LESS="-F X -R -P ?f%f .?n?m(file %i of %m) ..?ltlines %lt-%lb?L/%L. :
            byte %bB?s/%s. .?e(END) ?x- Next\: %x.:?pB%pB\%..%t"  

# environment variables for colored man pages, escape code syntax below
export LESS_TERMCAP_ti=$'\e[01;37m'         # white
export LESS_TERMCAP_mb=$'\e[38;5;117m'      # light blue
export LESS_TERMCAP_md=$'\e[38;5;117m'      # light blue
export LESS_TERMCAP_me=$'\e[0m'             # color reset
export LESS_TERMCAP_us=$'\e[01;33m'         # yellow
export LESS_TERMCAP_ue=$'\e[0m'             # color reset

# environment variables for printing process stats if a command takes > n seconds
export REPORTTIME=1
export TIMEFMT='
> %J
  | Time:   [38;5;159m%E[0m total time, %U user time, %S kernel time
  | Disk:   [38;5;159m%F[0m major page faults (pages loaded from disk)  
  | System: [38;5;159m%P[0m CPU used, [38;5;159m%M[0m KB max memory used'

# Useful zsh functions and modules
autoload -U colors && colors    # zsh function that loads colors w/ names into 'fg' & 'bg' arrays
autoload zcalc                  # calculator
autoload zmv                    # zsh batch file renamer ex: zmv '(*).txt' '$1.md'

alias curlperf='curl -w "*******************************
Summary (values are cumulative)
*******************************
  1. DNS lookup:    %{time_namelookup}
  2. TCP connected: %{time_connect}
  3. TTFB           %{time_starttransfer}
  4. Total time:    [38;5;117m%{time_total} secs [0m
  -------------------------------
  HTTP code:        %{http_code}
  Avg speed:        %{speed_download} Bps
  Received:         %{size_download} bytes\n" -o /dev/null $1'

# command aliases for different systems (Darwin = Mac)
if [[ `uname` == "Darwin" ]] then
    # if the command gls exists, gls is part of the GNU standard version of ls that can be installed on a Mac (brew install coreutils)
    # the 'g' prefix is added by homebrew to avoid naming collisions, gls, gcat etc...
    if (( $+commands[gls] )) ; then
        # remove date entirely for day-to-day usage
        alias ls='gls -Alh --color --time-style="+" --group-directories-first'                            
        # use English sentence style date when needed ex: [Tue, Jan 11 2011 @ 11:01 am]
        # format specifiers @ http://www.gnu.org/software/coreutils/manual/html_node/date-invocation.html#date-invocation 
        alias lsd='gls -Alh --color --time-style="+[%a, %b %_d %Y @ %l:%M %P]" --group-directories-first; echo Today is `date "+%a, %b %_d %Y @ %l:%M %p"`'  
    else
        alias ls='ls -Alhg'
    fi
else
    # assume GNU ls is available
    alias ls='ls -Alh --color --time-style="+—" --group-directories-first'                                 
    alias lsd='ls -Alh --color --time-style="+[%a, %b %_d %Y @ %l:%M %P]" --group-directories-first'   
fi

# .zshrc.local should contain system specific settings, aliases, exports, custom $PATH, etc...
if [[ -e "$HOME/.zshrc.local" ]] then
    source $HOME/.zshrc.local
fi

# sensible ls_colors
# di=directory (dark blue/purple), ln=sym link (light blue), ex=executable (green)
# mi=orphaned symlinks (red), tw=directory that allows r/w by all, deletes only by owner (dark blue)
# st=directory that allows deletes only by owner (cyan)
export LS_COLORS='di=38;5;61:ln=38;5;110:ex=38;5;72:mi=38;5;88:tw=38;5;25:st=38;5;38'

# tests whether a function exists, used when an old version of ZSH doesn't have vcs_info
function function_exists () {
    local -a files
    # This expands occurrences of $1 anywhere in $fpath,
    # removing files that don't exist.
    files=(${^fpath}/$1(N))
    # Success if any files exist.
    (( ${#files} ))
}

if function_exists vcs_info; then
    autoload -Uz vcs_info
fi

# custom prompt
# %{ ... %} tells zsh to disregard the contained characters when calculating the length of the prompt 
# (in order correctly position the cursor)
local p_delim="%{[38;5;130m%}>%{$reset_color%}"       # > as a delimiter

# dynamic prompt customization point, precmd gets called just before every command prompt
function precmd {
    if function_exists vcs_info; then
        vcs_info
    fi 

    # current working dir
    local p_cwd="%{[38;5;180m%}%3~%{$reset_color%}"        
    local p_userColor='[38;5;70m'
    
    # if $EUID is zero then we're running as root, change the color of the username from purple to red
    if [ $EUID -eq 0 ]; then
        local p_userColor='[01;38;5;124m'
    fi

    # p_hostname is defined in .zshrc.local It's useful for creating a friendly 
    # name in our prompt when we can't actually edit the hostname 
    if [[ -z "$p_hostName" ]]; then
        local p_user_at_host="%{$p_userColor%}%n%{$reset_color%}@%m" 
    else
        local p_user_at_host="%{$p_userColor%}%n%{$reset_color%}@$p_hostName" 
    fi
        
    if [[ -n "$vcs_info_msg_0_" ]]; then
        local p_vcs="%{[38;5;180m%}${vcs_info_msg_0_}%{$reset_color%}"
    fi

    local p_ret_status="[%(?.%?.%{[38;5;124m%}%?%{$reset_color%})]"

    PROMPT="${p_cwd}${p_vcs}
${p_user_at_host} ${p_ret_status} ${p_delim} "

}

# badass ZSH script that adds live syntax highlighting to command arguments
# https://github.com/zsh-users/zsh-syntax-highlighting 
dotfilesDir=`readlink ~/.zshrc`
dotfilesDir=`dirname $dotfilesDir`
if [[ -e "$dotfilesDir/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] then
    source $dotfilesDir/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

    # enable colored braces/parens & custom patterns, great when using zcalc
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

    # change the zsh-highlighing default colors
    ZSH_HIGHLIGHT_STYLES[globbing]='fg=blue,bold'
    ZSH_HIGHLIGHT_STYLES[path]='bold'
    ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=cyan'
    ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=cyan'
    ZSH_HIGHLIGHT_STYLES[path_prefix]='none'
    ZSH_HIGHLIGHT_STYLES[path_approx]='none'
fi

tname() {echo -ne "\e]1;$1\a"}

# Create or attach tmux session, name the current tab, and cd into the directory (if given)
# If inside a tmux session it wont create nested sessions
# ex: tm                  <- New/attach tmux session in current directory
# ex: tm ~/dotfiles       <- New/attach tmux session and cd ~/dotfiles
# ex: tm ~/dotfiles poop  <- New/attach tmux session named "poop" and cd ~/dotfiles
tm() {
    if [[ $#. -eq 2 ]]; then
        local name=$2
        local directory=$1
    elif [[ $#. -eq 1 ]]; then
        local name=`basename $1`
        local directory=$1
    else
        local name=`basename $PWD`
        local directory=$PWD
    fi
    # rename the current tab, cd into dir, if NOT in tmux session try attaching OR if NOT in tmux session try new session
    tname "$name" && cd "$directory" && [ -z "$TMUX" ] && tmux attach -d -t $name 2>/dev/null || [ -z "$TMUX" ] && tmux new-session -s $name
}

# ESC '  Quote the current line; that is, put a `'' character at the beginning and the end, and convert all `'' characters to `'\'''  
# ^ a    Move to beginning of line
# ^ e    Move to end of line
# ^ xf   Move to next typed character
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
#        || ||       ||       |||__________ dark yellow background color (100)
#        || ||       ||____________________ aqua foreground color (50)
#        || ||_____________________________ bold text attribute (01) 
#        ||________________________________ hit ctrl-v then esc to start escape sequence*
#
# * In most cases the escape sequence can also be written as \E, \033, or \x1b, 
# but you must it doesn't always work b/c of inconsistent escaping of \ through
# other commands
#
# The same as aboove, shortcut to change foreground to aqua (50)
# print '[38;05;50m poop [00 '
# 
# text attributes
#   0=RESET     1=BOLD              4=underline 24=not underline, 
#   5=blinking  25=notblinking      7=inverse   27=notinverse    
#   22=not bold
# 
# colors
#   1-255    
