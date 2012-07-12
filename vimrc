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
syntax on	"sytnax highlighting
colorscheme  xoria256-ingelmo  " ingelmo

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

" Show syntax highlighting groups for word under cursor
" CTRL+S CTRL+P
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" Status Line Format **********************************************************************
set statusline=\ %{IsDirty()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l/%L:%c

function! IsDirty()
    if &paste
        return 'PASTE MODE  '
    else
        return ''
    endif
endfunction
