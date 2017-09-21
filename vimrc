" install vim-plug if not present
if ( empty(glob('$HOME/.vim/autoload/plug.vim')) && executable("vim") )
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source ~/.vimrc
endif

let hostname = substitute(system('hostname'), '\n', '', '')

" {{{ PLUGINS
call plug#begin('~/.vim/plugged')

" {{{ ESSENTIAL
"
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-obsession'
Plug 'ajh17/VimCompletesMe'
Plug 'coderifous/textobj-word-column.vim'
Plug 'romainl/vim-qf'
Plug 'wellle/targets.vim'
Plug 'vim-scripts/VisIncr'
Plug 'rhysd/vim-clang-format'

Plug 'ludovicchabant/vim-gutentags'
let g:gutentags_ctags_executable_haskell = 'gutenhasktags'
let gutentags_project_info = [
  \ {'type': 'haskell', 'glob': '*.cabal'},
  \ {'type': 'haskell', 'glob': '*/*.hs'},
  \ {'type': 'haskell', 'glob': 'stack.yaml'},
  \ {'type': 'haskell', 'glob': '*.hs'}
  \ ]

Plug 'lervag/vimtex'
let g:vimtex_quickfix_ignore_all_warnings=1

Plug 'godlygeek/tabular'
vnoremap <Enter> :Tab<Space>/

Plug 'junegunn/vim-journal'

Plug 'ntpeters/vim-better-whitespace'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

let g:fzf_command_prefix = 'Fzf'
let g:fzf_layout = { 'down': '20%' }
nnoremap <leader>f :FzfFiles<CR>
nnoremap <leader>t :FzfBTags<CR>
nnoremap <leader>T :FzfTags<CR>
nnoremap <leader>w :FzfWindows<CR>
nnoremap <leader>b :FzfBuffers<CR>

Plug 'mhinz/vim-grepper'
nnoremap <leader>g :Grepper<CR>
" }}}

" {{{ LANGUAGE-SUPPORT
Plug 'parnmatt/vim-root'
Plug 'rust-lang/rust.vim', { 'for' : 'rust' }

Plug 'neovimhaskell/haskell-vim', { 'for' : 'haskell' }
let g:haskell_enable_quantification = 1
let g:haskell_enable_recursivedo = 1
let g:haskell_enable_arrowsyntax = 1
let g:haskell_enable_pattern_synonyms = 1
let g:haskell_enable_typeroles = 1
let g:haskell_enable_static_pointers = 1

Plug 'vim-pandoc/vim-pandoc', { 'for' : ['markdown', 'pdc'] }
Plug 'vim-pandoc/vim-pandoc-syntax', { 'for' : ['markdown', 'pdc'] }
let g:pandoc#filetypes#handled = ["pandoc", "markdown"]
let g:pandoc#filetypes#pandoc_markdown = 0
" }}}

" {{{ APPEARANCE
Plug 'justinmk/vim-syntax-extra'
Plug 'flazz/vim-colorschemes'
Plug 'arcticicestudio/nord-vim'

" Plug 'itchyny/lightline.vim'
" let g:lightline = {
"       \ 'colorscheme': 'nord',
"       \ }
" }}}

" {{{ USEFUL AND UNINTRUSIVE
Plug 'tpope/vim-repeat'
" }}}

call plug#end()
" }}}

" {{{ BACKUP/UNDO/SWAP FILES
silent !mkdir ~/.vim/backups > /dev/null 2>&1
silent !mkdir ~/.vim/backups/files > /dev/null 2>&1
set backupdir=~/.vim/backups/files
set backup

silent !mkdir ~/.vim/backups/undo_history > /dev/null 2>&1
set undodir=~/.vim/backups/undo_history
set undofile

silent !mkdir ~/.vim/backups/swap_files > /dev/null 2>&1
set directory=~/.vim/backups/swap_files
" }}}

" {{{ VIM SETTINGS
set foldmethod=marker
set number
set numberwidth=3
set wrap

au FileType cpp setlocal cindent cino=j1,(0,ws,Ws

color blazer
set background=dark
hi StatusLine   ctermfg=237     ctermbg=254     cterm=NONE
hi StatusLineNC ctermfg=254     ctermbg=237     cterm=NONE
hi Search       cterm=NONE      ctermfg=black   ctermbg=yellow
hi Comment      cterm=NONE      ctermfg=24
hi LineNr       ctermfg=8

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

map <SPACE> <leader>

"highlight SpecialKey ctermfg=White ctermbg=Red
"set list
"set listchars=tab:T>
set mouse=a

set autoindent
set expandtab
set tabstop=2
set shiftwidth=4

set hls is ic scs

if executable("ag")
  set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case\ --column
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.o,*.pyc

" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" }}}

" {{{ ALIASES
fun! SetupCommandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun

call SetupCommandAlias('W', 'w')
call SetupCommandAlias('Wa', 'wa')
call SetupCommandAlias('WA', 'wa')
call SetupCommandAlias('Wq', 'wq')
call SetupCommandAlias('Wqa', 'wqa')
call SetupCommandAlias('WQa', 'wqa')
call SetupCommandAlias('WQA', 'wqa')
call SetupCommandAlias('Vsplit', 'vsplit')
call SetupCommandAlias('VSplit', 'vsplit')
call SetupCommandAlias('Split', 'split')
call SetupCommandAlias('SPlit', 'split')

augroup vimrc_todo
    au!
    au Syntax * syn match MyTodo /\v<(DEPRECATED|FIXME|NOTE|TODO|OPTIMIZE|XXX):/
          \ containedin=.*Comment,vimCommentTitle
augroup END
hi def link MyTodo Todo
" }}}
