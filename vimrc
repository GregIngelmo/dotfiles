call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" File types, wikipedia, & json
autocmd BufRead,BufNewFile *.wiki setfiletype Wikipedia
autocmd BufRead,BufNewFile *.wikipedia.org* setfiletype Wikipedia
autocmd BufRead,BufNewFile *.json setfiletype javascript

" Execute Rooter when opening these types of files. Rooter cds to the directory of the file
autocmd BufRead,BufEnter *.py,*.html,*.haml,*.css,*.js :Rooter

" Always cd using the active buffers directory
autocmd BufEnter * lcd %:p:h

" Searching *******************************************************************
set hlsearch	" highlight search term
set incsearch	" Incremental search, search as you type
set ignorecase	" Ignore case when searching
set smartcase	" Ignore case when searching lowercase

" Colors **********************************************************************
syntax on	"sytnax highlighting
colorscheme  ingelmo

" Code folding ****************************************************************
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use

" Vim UI **********************************************************************
set number 	"line numbers
set ruler	"show the cursor position bottomr right (row/col)
set showtabline=2   "Always ctrl

" Other  **********************************************************************
set smartindent
set encoding=utf-8
set tabstop=4
set shiftwidth=4
set expandtab           "Use spaces not tabs
set nowrap
let g:NERDTreeWinSize = 40  

" More sytnax highlighting for python, see ~/vim/syntax/python3.0.vim
"let python_highlight_all = 1
"let g:Powerline_symbols = 'fancy'

" Mappings  **********************************************************************
:inoremap jk <esc>

" Always show the status line
set laststatus=2

" Allow shift key selection of text in insert mode
if has("gui_macvim")
    let macvim_hig_shift_movement = 1
endif

" Show syntax highlighting groups for word under cursor CTRL+P
" See http://vimcasts.org/episodes/creating-colorschemes-for-vim/
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
