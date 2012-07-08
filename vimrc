call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" File types, wikipedia, & json
autocmd BufRead,BufNewFile *.wiki setfiletype Wikipedia
autocmd BufRead,BufNewFile *.wikipedia.org* setfiletype Wikipedia
autocmd BufRead,BufNewFile *.json setfiletype javascript

" Execute Rooter when opening these types of files. Rooter cds to the directory of the file
autocmd BufRead,BufEnter *.py,*.html,*.haml,*.css,*.js :Rooter

" Searching *******************************************************************
set hlsearch	" highlight search term 
set incsearch	" Incremental search, search as you type
set ignorecase	" Ignore case when searching
set smartcase	" Ignore case when searching lowercase

" Colors **********************************************************************
colorscheme ir_black
"set background=dark "must manually set otherwise VIM commandline looks like crap (black on black)
syntax on	"sytnax highlighting

" Code folding ****************************************************************
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use

" Vim UI **********************************************************************
set number 	"line numbers
set ruler	"show the cursor position bottomr right (row/col)

" Other  **********************************************************************
set smartindent
set encoding=utf-8
set tabstop=4
set shiftwidth=4
set expandtab           "Use spaces not tabs
set nowrap

" More sytnax highlighting for python, see ~/vim/syntax/python3.0.vim
let python_highlight_all = 1

" Mappings  **********************************************************************
:imap ii <Esc> 

" Always show the status line
set laststatus=2

" Allow shift key selection of text 
if has("gui_macvim")
    let macvim_hig_shift_movement = 1
endif

" Status Line Format **********************************************************************
set statusline=\ %{IsDirty()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l/%L:%c

function! IsDirty()
    if &paste
        return 'PASTE MODE  '
    else
        return ''
    endif
endfunction

set foldtext=MyFoldText()
function! MyFoldText()
  let line = getline(v:foldstart)
  if match( line, '^[ \t]*\(\/\*\|\/\/\)[*/\\]*[ \t]*$' ) == 0
    let initial = substitute( line, '^\([ \t]\)*\(\/\*\|\/\/\)\(.*\)', '\1\2', '' )
    let linenum = v:foldstart + 1
    while linenum < v:foldend
      let line = getline( linenum )
      let comment_content = substitute( line, '^\([ \t\/\*]*\)\(.*\)$', '\2', 'g' )
      if comment_content != ''
        break
      endif
      let linenum = linenum + 1
    endwhile
    let sub = initial . ' ' . comment_content
  else
    let sub = line
    let startbrace = substitute( line, '^.*{[ \t]*$', '{', 'g')
    if startbrace == '{'
      let line = getline(v:foldend)
      let endbrace = substitute( line, '^[ \t]*}\(.*\)$', '}', 'g')
      if endbrace == '}'
        let sub = sub.substitute( line, '^[ \t]*}\(.*\)$', '...}\1', 'g')
      endif
    endif
  endif
  let n = v:foldend - v:foldstart + 1
  let info = " " . n . " lines"
  let sub = sub . "                                                                                                                  "
  let num_w = getwinvar( 0, '&number' ) * getwinvar( 0, '&numberwidth' )
  let fold_w = getwinvar( 0, '&foldcolumn' )
  let sub = strpart( sub, 0, winwidth(0) - strlen( info ) - num_w - fold_w - 1 )
  return sub . info
endfunction

