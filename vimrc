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
Plug 'ajh17/VimCompletesMe'
Plug 'tpope/vim-commentary'
Plug 'coderifous/textobj-word-column.vim'
Plug 'romainl/vim-qf'
Plug 'wellle/targets.vim'
Plug 'tpope/vim-fugitive'
Plug 'jceb/vim-orgmode'
Plug 'vim-scripts/VisIncr'
let g:utl_cfg_hdl_scm_http_system = "silent !open -a Safari '%u'"

Plug 'justinmk/vim-sneak'
let g:sneak#streak = 1

Plug 'Rip-Rip/clang_complete'
let g:clang_close_preview=1
if hostname =~ "macbook"
   let g:clang_library_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/libclang.dylib'
elseif hostname =~ "lxplus"
   let g:clang_library_path='/afs/cern.ch/sw/lcg/external/llvm/3.9.0/x86_64-slc6/lib/libclang.so'
elseif hostname =~ "titan"
endif

" if hostname =~ "macbook"
"     Plug 'vim-syntastic/syntastic'
"     let g:syntastic_always_populate_loc_list = 1
"     let g:syntastic_auto_loc_list = 1
"     let g:syntastic_check_on_open = 1
"     let g:syntastic_check_on_wq = 0
" endif

Plug 'mattn/calendar-vim'
Plug 'vim-scripts/utl.vim'
Plug 'vim-scripts/SyntaxRange'

Plug 'ludovicchabant/vim-gutentags'
let g:gutentags_ctags_executable_haskell = 'gutenhasktags'
let gutentags_project_info = [
  \ {'type': 'haskell', 'glob': '*.cabal'},
  \ {'type': 'haskell', 'glob': '*/*.hs'},
  \ {'type': 'haskell', 'glob': 'stack.yaml'},
  \ {'type': 'haskell', 'glob': '*.hs'}
  \ ]

Plug 'majutsushi/tagbar'
set updatetime=1000
nnoremap <leader>b :TagbarToggle<CR>

Plug 'dracula/vim'

Plug 'lervag/vimtex'
let g:vimtex_quickfix_ignore_all_warnings=1

Plug 'godlygeek/tabular'
vnoremap <Enter> :Tab<Space>/

Plug 'ntpeters/vim-better-whitespace'
"autocmd BufWritePre * StripWhitespace

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

let g:fzf_command_prefix = 'Fzf'
let g:fzf_layout = { 'down': '10%' }
nnoremap <leader>f :FzfFiles<CR>
nnoremap <leader>t :FzfBTags<CR>
nnoremap <leader>T :FzfTags<CR>
nnoremap <leader>w :FzfWindows<CR>

nnoremap <silent> <Leader>s :call fzf#run({
\   'down': '40%',
\   'sink': 'botright split' })<CR>

nnoremap <silent> <Leader>v :call fzf#run({
\   'right': winwidth('.') / 2,
\   'sink':  'vertical botright split' })<CR>

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
Plug 'airblade/vim-gitgutter'
Plug 'justinmk/vim-syntax-extra'
Plug 'flazz/vim-colorschemes'

Plug 'itchyny/lightline.vim'
let g:lightline = {
      \ 'colorscheme': 'Dracula',
      \ }
Plug 'edkolev/tmuxline.vim'
" }}}

" {{{ USEFUL AND UNINTRUSIVE
Plug 'tpope/vim-speeddating'
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
set nowrap

set background=dark
color dracula
set guifont=InputMono\ Medium:h14
hi MatchParen cterm=bold ctermbg=magenta ctermfg=white

map <SPACE> <leader>

"highlight SpecialKey ctermfg=White ctermbg=Red
"set list
"set listchars=tab:T>
set mouse=a

set autoindent
set expandtab
set tabstop=4
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
call SetupCommandAlias('Wqa', 'wqa')
call SetupCommandAlias('WQa', 'wqa')
call SetupCommandAlias('WQA', 'wqa')
call SetupCommandAlias('Vsplit', 'vsplit')
call SetupCommandAlias('VSplit', 'vsplit')
call SetupCommandAlias('Split', 'split')
call SetupCommandAlias('SPlit', 'split')
" }}}

" {{{ GENERAL KEYBINDS
" tnoremap <C-w>h <C-\><C-n><C-w>h
" tnoremap <C-w>j <C-\><C-n><C-w>j
" tnoremap <C-w>k <C-\><C-n><C-w>k
" tnoremap <C-w>l <C-\><C-n><C-w>l
" autocmd BufWinEnter,WinEnter term://* startinsert
" }}}
