set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'
let g:ycm_min_num_of_chars_for_completion=1
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_complete_in_comments = 1

Plugin 'scrooloose/nerdtree'
" <F2> toggle explorer
map <F4> :NERDTreeToggle<CR>
" auto open tree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" auto close tree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeIgnore=['\~$']  " set ignore
let NERDTreeShowHidden=1    " show hidden files
let NERDTreeMinimalUI=1     " don't show hint
Plugin 'Xuyuanp/nerdtree-git-plugin'
let g:NERDTreeIndicatorMapCustom = {
            \ "Modified"  : "~",
            \ "Staged"    : "+",
            \ "Untracked" : "*",
            \ "Renamed"   : "»",
            \ "Unmerged"  : "=",
            \ "Deleted"   : "-",
            \ "Dirty"     : "x",
            \ "Clean"     : "ø",
            \ "Unknown"   : "?"
            \ }

" Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-commentary'
nmap <BS> gcc
vmap <BS> gc
Plugin 'tpope/vim-fugitive'
set diffopt+=vertical
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-sleuth'
let g:sleuth_automatic = 0 " desable auto detect, manually run cmd :Sleuth
Plugin 'tpope/vim-repeat'

Plugin 'scrooloose/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = 'eslint'

Plugin 'Chiel92/vim-autoformat'
" let g:autoformat_verbosemode=1
" let b:formatters_javascript = ['jsbeautify_javascript', 'eslint']
noremap <A-i> :Autoformat<CR>

" Plugin 'Raimondi/delimitMate'
Plugin 'jiangmiao/auto-pairs'
let g:AutoPairsShortcutToggle = ''

Plugin 'ctrlpvim/ctrlp.vim'
let g:ctrlp_match_window='bottom,order:ttb,min:1,max:10,results:10'    " window position
set wildignore+=*/tmp/*,*.so,*.swp,*.zip                " ignore files
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
" ignore files in .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
if executable('ag')
    " Use Ag over Grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
endif

Plugin 'mileszs/ack.vim'
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif
cnoreabbrev Ack Ack!
" Plugin 'vim-scripts/nerdtree-ack'

Plugin 'dyng/ctrlsf.vim'
nmap     <C-f>f <Plug>CtrlSFPrompt
vmap     <C-f>f <Plug>CtrlSFVwordPath
vmap     <C-f>F <Plug>CtrlSFVwordExec
nmap     <C-f>n <Plug>CtrlSFCwordPath
nmap     <C-f>p <Plug>CtrlSFPwordPath
nnoremap <C-f>o :CtrlSFOpen<CR>
nnoremap <C-f>t :CtrlSFToggle<CR>
inoremap <C-f>t <Esc>:CtrlSFToggle<CR>


Plugin 'easymotion/vim-easymotion'
let g:EasyMotion_smartcase = 1

Plugin 'mattn/emmet-vim'
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

Plugin 'sjl/gundo.vim'
if has('python3')
    let g:gundo_prefer_python3 = 1
endif
nnoremap <F3> :GundoToggle<CR>

Plugin 'terryma/vim-multiple-cursors'
Plugin 'majutsushi/tagbar'
nmap <F5> :TagbarToggle<CR>
let tagbar_width=32

" Plugin 'benmills/vimux'
Plugin 'christoomey/vim-tmux-navigator'
let g:tmux_navigator_no_mappings = 1
" Disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
nnoremap <silent> <C-\> :TmuxNavigatePrevious<cr>

" Plugin 'suan/vim-instant-markdown'
" Plugin 'JamshedVesuna/vim-markdown-preview'
Plugin 'iamcco/markdown-preview.vim'
" Plugin 'iamcco/mathjax-support-for-mkdp'
Plugin 'pangloss/vim-javascript'

Plugin 'vim-airline/vim-airline'
Plugin 'airblade/vim-gitgutter'

Plugin 'flazz/vim-colorschemes'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Enable extended % matching
runtime macros/matchit.vim
" auto reload config
autocmd BufWritePost $MYVIMRC source $MYVIMRC

" undo
set undodir=~/.vim/.undo_history/
set undofile

syntax on
colorscheme molokai
" set t_Co=256
" let g:solarized_termtrans=1
" let g:solarized_termcolors=256

" hightlight cursor
highlight CursorLine   cterm=NONE ctermbg=black ctermfg=green guibg=NONE guifg=NONE
highlight CursorColumn cterm=NONE ctermbg=black ctermfg=green guibg=NONE guifg=NONE
autocmd WinLeave * set nocursorline nocursorcolumn
" autocmd WinEnter * set cursorline cursorcolumn

" enable mouse
if has('mouse')
    set mouse=nv
endif

set history=200
set nrformats=          " treat number as decimal
set clipboard=unnamedplus       " Yanks go on clipboard instead

" open split window
set splitright
set splitbelow

" format
set formatoptions-=o         " Do not insert the current comment leader after hitting 'o' or 'O' in Normal mode.
set formatoptions-=r         " Do not automatically insert a comment leader after an enter
set formatoptions-=t         " Do not auto-wrap text using textwidth (does not apply to comments)

set tabstop=4               " set this width of a tab
set softtabstop=4           " set the number of columns for a tab
set shiftwidth=4            " set the indent width
set expandtab               " expand tab to spaces

set scrolloff=7
set nowrap
set hidden
set number
set hlsearch
set incsearch

if has("autocmd")
    autocmd FileType make setlocal noet
    autocmd FileType javascript setlocal ts=4 sts=4 sw=4 et
endif

" fix confuse brace issue
" A massively simplified take on https://github.com/chreekat/vim-paren-crosshairs
func! s:matchparen_cursorcolumn_setup()
    augroup matchparen_cursorcolumn
        autocmd!
        autocmd CursorMoved * if get(w:, "paren_hl_on", 0) | set cursorcolumn | else | set nocursorcolumn | endif
        autocmd InsertEnter * set nocursorcolumn
    augroup END
endf
if !&cursorcolumn
    augroup matchparen_cursorcolumn_setup
        autocmd!
        " - Add the event _only_ if matchparen is enabled.
        " - Event must be added _after_ matchparen loaded (so we can react to w:paren_hl_on).
        autocmd CursorMoved * if exists("#matchparen#CursorMoved") | call <sid>matchparen_cursorcolumn_setup() | endif
                    \ | autocmd! matchparen_cursorcolumn_setup
    augroup END
endif

set timeoutlen=1000 ttimeoutlen=0
" fix alt key-mapping
for i in range(char2nr('a'), char2nr('z'))
    let i = nr2char(i)
    exec "set <M-".i.">=\<Esc>".i
    exec "imap \<Esc>".i." <M-".i.">"
endfor
for i in range(char2nr('0'), char2nr('9'))
    let i = nr2char(i)
    exec "set <M-".i.">=\<Esc>".i
    exec "imap \<Esc>".i." <M-".i.">"
endfor
" set <A-a>=a
map <A-a> :echo "A-a received"<CR>
" set <S-Down>=[1;2B
" map <S-Down> :echo "S-down received"<CR>

" key mapping
" leader
let mapleader = "\<Space>"
let g:mapleader = "\<Space>"

" Speed up scrolling of the viewport slightly
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" map ctrl + s to save file. need add 'stty -ixon' in the .bashrc or .zshrc
" if you use vim in the terminal.
inoremap <C-s> <Esc>:update<CR>
nnoremap <C-s> :update<CR>

" disable arrow
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

" Y Make Y behave like other capitals
nnoremap Y  y$

" Keep search pattern at the center of the screen.
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" temporary disable hlsearch
" nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
nnoremap <silent> <A-l> :<C-u>nohlsearch<CR>

" switch buffer
" noremap <silent> <Left> :bp<CR>
" noremap <silent> <Right> :bn<CR>

" xnoremap p pgvy

" write with sudo
cmap w!! w !sudo tee % > /dev/null
" move cursor like readline
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

