" Vim color file
"
" Name:         ingelmo.vim
" Version:      1.0
" Maintainer:   Greg Ingelmo
"
" Custom color scheme based on xoria-256
" Base palette is inluded as part of ColorSchemer scheme (ingelmo-vim.cs)
"  
" For a specific filetype highlighting rules issue :syntax list when a file of
" that type is opened.

" Initialization 
if &t_Co != 256 && ! has("gui_running")
  echomsg ""
  echomsg "err: please use GUI or a 256-color terminal (so that t_Co=256 could be set)"
  echomsg ""
  finish
endif

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "ingelmo"

hi Normal       ctermfg=250 guifg=#d0d0d0 ctermbg=black guibg=#000000 
hi Cursor                                 ctermbg=214 guibg=#ffaf00
hi CursorColumn                           ctermbg=238 guibg=#444444
hi CursorLine                             ctermbg=237 guibg=#3a3a3a cterm=none gui=none
hi ErrorMsg     ctermfg=124 guifg=#ffffff ctermbg=0   guibg=#800000
hi FoldColumn   ctermfg=247 guifg=#9e9e9e ctermbg=0   guibg=#000000
hi Folded       ctermfg=234 guifg=#2e2e2e ctermbg=0   guibg=#000000
hi LineNr       ctermfg=247 guifg=#9e9e9e ctermbg=0 guibg=#121212
hi MatchParen   ctermfg=82 guifg=#5fff00 ctermbg=0   guibg=#000000 cterm=bold gui=bold
" hi MoreMsg
hi NonText      ctermfg=247 guifg=#000000 ctermbg=0   guibg=#121212 cterm=bold gui=bold
hi Pmenu        ctermfg=0   guifg=#000000 ctermbg=250 guibg=#bcbcbc
hi PmenuSel     ctermfg=0   ctermbg=62  
hi PmenuSbar                              ctermbg=252 guibg=#d0d0d0
hi PmenuThumb   ctermfg=243 guifg=#767676
hi Search       ctermfg=0   ctermbg=62 
hi IncSearch    ctermfg=255 ctermbg=62 cterm=bold
hi SignColumn   ctermfg=248 guifg=#a8a8a8
hi SpecialKey   ctermfg=77  guifg=#5fdf5f
hi SpellBad     ctermfg=160 guifg=fg      ctermbg=bg                cterm=underline               guisp=#df0000
hi SpellCap     ctermfg=189 guifg=#dfdfff ctermbg=bg  guibg=bg      cterm=underline gui=underline
hi SpellRare    ctermfg=168 guifg=#df5f87 ctermbg=bg  guibg=bg      cterm=underline gui=underline
hi SpellLocal   ctermfg=98  guifg=#875fdf ctermbg=bg  guibg=bg      cterm=underline gui=underline
hi StatusLine   ctermfg=15  guifg=#ffffff ctermbg=239 guibg=#4e4e4e cterm=bold gui=bold
hi StatusLineNC ctermfg=249 guifg=#b2b2b2 ctermbg=237 guibg=#3a3a3a cterm=none gui=none
hi TabLine      ctermfg=fg  guifg=fg      ctermbg=242 guibg=#666666 cterm=none gui=none
hi TabLineFill  ctermfg=fg  guifg=fg      ctermbg=237 guibg=#3a3a3a cterm=none gui=none
hi Title        ctermfg=225 guifg=#ffdfff
hi Todo         ctermfg=255 ctermbg=0 cterm=underline
hi Underlined   ctermfg=39  guifg=#00afff                           cterm=underline gui=underline
hi VertSplit    ctermfg=237 guifg=#3a3a3a ctermbg=237 guibg=#3a3a3a cterm=none gui=none
" hi VIsualNOS    ctermfg=24  guifg=#005f87 ctermbg=153 guibg=#afdfff cterm=none gui=none
" hi Visual       ctermfg=24  guifg=#005f87 ctermbg=153 guibg=#afdfff
hi Visual       ctermfg=255 guifg=#eeeeee ctermbg=96  guibg=#875f87
" hi Visual       ctermfg=255 guifg=#eeeeee ctermbg=24  guibg=#005f87
hi VisualNOS    ctermfg=255 guifg=#eeeeee ctermbg=60  guibg=#5f5f87
hi WildMenu     ctermfg=0   guifg=#000000 ctermbg=150 guibg=#afdf87 cterm=bold gui=bold

"" Syntax highlighting 
hi Comment      ctermfg=238 guifg=#666666   " Comments in gray
hi Constant     ctermfg=66  guifg=#5a9a77   " Strings in green
hi Constant2    ctermfg=65                  " Other Strings in darker green
hi Identifier   ctermfg=137 guifg=#b87a41   " Keywords in orange
hi Identifier2  ctermfg=173                 " Keywords in stronger orange
hi Ignore       ctermfg=238 guifg=#444444   " Dark gray
hi Number       ctermfg=144 guifg=#d6c895   " Numbers in yellow
hi PreProc      ctermfg=150 guifg=#95b576   " Light green
hi Special      ctermfg=174 guifg=#df8787   " Sepcial chars in magenta
hi Statement    ctermfg=67  guifg=#5f87af   " Keywords in blue 
hi Statement2   ctermfg=68  guifg=#6688dd   " Keywords in lighter blue 
hi Statement3   ctermfg=33                  " Keywords in very bright blue
hi Statement4   ctermfg=61                  " Keywords in purple
hi Arguments    ctermfg=95                  " Method arguments in brown
hi Type         ctermfg=110 guifg=#afafd7   " Type in purple blue 
hi Error        ctermfg=88  guifg=#af0000 ctermbg=0   guibg=#000000
hi Hyperlink    ctermfg=25
hi Purple       ctermfg=61
hi Paren        ctermfg=192
hi BracesBrackets ctermfg=24

""" Go
hi link goRawString Constant2
hi link goDirective Statement4
hi link goStruct Statement3
hi link goStructDef Statement3
hi link goMethod Statement2
hi link goFunction Normal
hi link goOperator Normal
hi goBuiltins ctermfg=24
hi goStatement ctermfg=167 " 124 130  161 167
hi link goType Arguments
hi link goSignedInts Arguments
hi link goFloats Arguments 
hi link goUnsignedInts Arguments
hi link goDeclType Arguments
hi link goRepeat Identifier 
hi goConstants ctermfg=7 " 217
hi link goLabel Identifier
hi link goDeclaration Statement4
""" Tagbar
hi link TagbarKind       Statement4
hi link TagbarNestedKind Statement2
hi link TagbarScope      Statement3
hi link TagbarSignature  Arguments
hi TagbarAccessPublic ctermfg=0
hi link TagbarAccessPrivate TagbarAccessPublic
hi link TagbarAccessProtected  TagbarAccessPublic

""" Javascript
hi link javaScriptStatement Identifier
hi link javaScriptNumber Number
" 24 88 166
hi link javaScriptBraces BracesBrackets
hi link javaScriptBoolean Constant2
hi link javaScriptFuncKeyword Statement
hi link javaScriptFuncExp Statement4
" 95 117 124 130
hi link javaScriptFuncArg Arguments
hi link javaScriptConditional Identifier
hi link javaScriptParens Normal
hi link javaScriptOpSymbols Normal
hi link javaScriptGlobal Statement3
hi javaScriptDocTags ctermfg=243
hi link javaScriptDocParam javaScriptFuncArg

hi link Conditional Identifier
hi link Command Conditional

""" vim-ruby-debugger
hi link rdebugParent Statement2
hi link rdebugChild Statement2
hi link rdebugValue Normal
hi link rdebugType Statement
hi link rdebugPart Comment
hi link rdebugPartFile Comment

""" vim
hi link vimHiGroup Statement
hi link vimHighlight Identifier
hi link vimCommand Identifier

""" Vim help pages
hi link helpSpecial Identifier
hi link helpHyperTextEntry Hyperlink
hi link helpSectionDelim Statement
hi link helpHeader Statement

""" python 
hi link pythonFunction Statement4
hi link pythonStatement Statement
hi link pythonRepeat Identifier
hi link pythonConditional Identifier
hi link pythonInclude Identifier
hi link pythonOperator Identifier
hi link pythonException Identifier
hi link pythonExceptions Error

""" Ruby 
hi link rubyBlock Identifier
hi link rubyDoBlock Normal
hi link rubyConstant Statement 
hi link rubyPseudoVariable Type 
hi link rubyStringDelimiter Constant 
hi link rubySymbol Constant2
hi link rubyClass Identifier 
hi link rubyClassDeclaration Statement 
hi link rubyFunction Statement
hi link rubyDefine Identifier
hi link rubyInclude Identifier
hi link rubyInstanceVariable Normal
hi link rubyBlockParameter Arguments
hi rubyArrayDelimiter ctermfg=24
hi rubyCurlyBlockDelimiter ctermfg=24
hi link rubyLocalVariableOrMethod Normal
hi link rubyControl Identifier
hi link rubyDefine Statement
hi link rubyMethodNameTag Statement4
hi link rubyPseudoVariable Statement3

""" Django
hi link djangoTagBlock Statement
hi link djangoStatement Identifier
hi link djangoVarBlock Type

""" ZSH
hi link vimOption Type
hi link zshCommands Identifier
hi link zshKeyword Identifier
hi link zshKSHFunction Statement

""" Bufexplorer, remove all unecessary colors
hi link bufExplorerHelp Normal  
hi link bufExplorerSortBy Normal  
hi link bufExplorerCurBuf PreProc 
hi link bufExplorerAltBuf Normal  
hi link bufExplorerActBuf Normal  
hi link bufExplorerBufNbr Normal  

""" Shell scripts
hi shOption ctermfg=110 guifg=#78b3d0  " light cyan to match zsh highlighting
hi link shLoop Identifier
hi link zshSubstDelim Special
hi link zshSubst Constant2
hi link zshDeref zshSubst
hi link shFunction Statement4 

""" Git gutter
hi GitGutterAdd ctermfg=64
hi GitGutterChange ctermfg=55
hi link GitGutterChangeDelete Error
hi link GitGutterDelete Error
hi link GitGutterAddLine DiffAdd
hi link GitGutterChangeLine DiffChange
hi link GitGutterDeleteLine DiffDelete
hi link GitGutterChangeDeleteLine DiffDelete

""" Restructred text
hi link rstSections Statement
hi link rstInterpretedTextOrHyperlinkReference Identifier
hi link rstEmphasis Type
hi link rstStandaloneHyperlink Hyperlink
hi link rstStrongEmphasis Normal

""" Markdown
hi link markdownH1 Statement
hi link markdownH2 Statement
hi link markdownH3 Statement
hi link markdownH4 Statement
hi link markdownH5 Statement
hi link markdownHeadingRule Statement
hi link markdownHeadingDelimiter Statement
hi link markdownListMarker Identifier
hi link markdownUrl Identifier
hi link markdownCodeBlock Constant
hi link mkdURL Hyperlink
hi link mkdDelimiter Special

""" HTML
hi link htmlString Constant
hi link htmlTitle Normal
hi link htmlTag Comment
hi link htmlEndTag Comment
hi link htmlArg Identifier
hi link htmlLink Hyperlink
hi htmlH1 ctermfg=61 guifg=#6666aa
hi link htmlH2 htmlH1
hi link htmlH3 htmlH1
hi link htmlH3 htmlH1
hi link htmlH4 htmlH1
hi link djangoVarBlock Constant2

""" CSS
hi link cssClassName Statement
hi link cssFunction Normal
"""hi link cssPaddingProp Identifier
"""hi link cssMarginProp Identifier
hi link cssColor Number
hi link cssSelectorOp Normal
hi link cssBraces Normal
hi link cssTagName Identifier
hi link cssPseudoClassId Identifier

""" Less
hi link lessVariable Statement
hi link lessVariableValue Type

""" Javascript
hi link javascript Normal

""" Nerdtree
hi NERDTreeExecFile ctermfg=72  guifg=#d75f00
hi NERDTreeDir      ctermfg=61  guifg=#6666aa
hi NERDTreeLink     ctermfg=110 guifg=#d787af
hi NERDTreeCWD      ctermfg=180 guifg=#d787af
hi link NERDTreeUp NERDTreeDir
hi link NERDTreeDirSlash NERDTreeDir
hi link NERDTreeHelpTitle Normal

""" Tagbar
highlight default link TagbarComment    Comment
highlight default link TagbarKind       Identifier
highlight default link TagbarNestedKind TagbarKind
highlight default link TagbarScope      Statement
highlight default link TagbarType       Type
highlight default link TagbarSignature  SpecialKey
highlight default link TagbarPseudoID   NonText
highlight default link TagbarFoldIcon   NERDTreeDir
highlight default link TagbarHighlight  Search

""" INI
hig default link dosiniHeader Statement

""" vim
hi! link SignColumn LineNr

""" Json
highlight default link jsonBoolean Constant2
highlight default link jsonKey Statement
highlight default link jsonBraces BracesBrackets

""" Gitv
hi link gitvGraphEdge0 Statement
hi link gitvGraphEdge1 Arguments
hi gitvSubject ctermfg=248

""" Diff
hi diffAdded    ctermfg=150 guifg=#afdf87
hi diffRemoved  ctermfg=174 guifg=#df8787
hi diffAdd      ctermfg=bg  guifg=bg ctermbg=71 
hi diffDelete   ctermfg=bg  guifg=bg ctermbg=88
hi diffChange   ctermfg=bg  guifg=bg ctermbg=61
hi diffText     ctermfg=bg  guifg=bg ctermbg=174
hi link diffFile Statement4

""" Quickfix window
hi link qfFileName Statement2
hi link qfLineNr Comment
"
""" VimDebug {{{3
" FIXME
" you may want to set SignColumn highlight in your .vimrc
" :help sign
" :help SignColumn

" hi currentLine term=reverse cterm=reverse gui=reverse
" hi breakPoint  term=NONE    cterm=NONE    gui=NONE
" hi empty       term=NONE    cterm=NONE    gui=NONE

" sign define currentLine linehl=currentLine
" sign define breakPoint  linehl=breakPoint  text=>>
" sign define both        linehl=currentLine text=>>
" sign define empty       linehl=empty

