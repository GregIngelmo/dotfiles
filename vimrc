call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" File types, wikipedia, & json
autocmd BufRead,BufNewFile *.wiki setfiletype Wikipedia
autocmd BufRead,BufNewFile *.wikipedia.org* setfiletype Wikipedia
autocmd BufRead,BufNewFile *.json setfiletype javascript

" Always cd using the active buffers directory
autocmd BufEnter * lcd %:p:h

" Open Nerd tree on start and set focus to the empty buffer
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

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
set number 	        " Enable Line numbers
set showtabline=2   " Show the tab bar
set laststatus=2    " Show the status

" Other  **********************************************************************
set smartindent
set encoding=utf-8
set tabstop=4
set shiftwidth=4
set expandtab           "Use spaces not tabs
set nowrap
let g:NERDTreeWinSize = 40  
set noswapfile          "Disable the swap file

" ConqueTerm  ****************************************************************
let g:ConqueTerm_ReadUnfocused = 1
"let g:ConqueTerm_InsertOnEnter = 1
set updatetime=200  "uptime (ms) is how often vim runs its internal timer (don't set this any lower) 
let g:ConqueTerm_TERM='xterm'
" More sytnax highlighting for python, see ~/vim/syntax/python3.0.vim
"let python_highlight_all = 1

" Mappings  *****************************************************************
:inoremap jk <esc>

" Allow shift key selection of text in insert mode
if has("gui_macvim")
    let macvim_hig_shift_movement = 1
endif

if has('gui_running')
    " set guifont=Inconsolata-dz:h11
    set guifont=Inconsolata-dz\ for\ Powerline:h11                                    
    let g:Powerline_symbols = 'fancy'
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
