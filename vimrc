set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim


"$B!'(BBundleInstall$B!*(B -$B$9$Y$F$N%W%i%0%$%s$r99?7(B
"$B!'(BBundleSearch foo-foo$B%W%i%0%$%s$r8!:w(B
"$B!'%P%s%I%k8!:w!*(B foo-foo$B%W%i%0%$%s$N%P%C%U%!$r99?7$9$k(B
"$B!'(BBundleClean-$B%W%i%0%$%s$,(B.vimrc$B$GDj5A$5$l$F$$$J$$>l9g!"$9$Y$F$N%W%i%0%$%s$r%/%j!<%s%"%C%W$7$^$9(B
call vundle#begin()

"bookmark
Plugin 'kshenoy/vim-signature'
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
"$B%9%?!<%?%9%P!<I=<((B
Plugin 'itchyny/lightline.vim'
"$B%(%/%9%W%m!<%i!<(B
Plugin 'preservim/nerdtree'

":IndentGuidesEnable
":IndentGuidesDisable
":IndentGuidesToggle
"let g:indent_guides_enable_on_vim_startup = 1
"$B%$%s%G%s%H$r2D;k2=$9$k(B
Plugin 'nathanaelkane/vim-indent-guides'

Plugin 'joshdick/onedark.vim'
Plugin 'arcticicestudio/nord-vim'
" COMMANDS					*zenspace-commands*

":ZenSpaceOn					*:ZenSpaceOn*
"	Show Ideographic Space in current window.
"
":ZenSpaceOff					*:ZenSpaceOff*
"	Don't show Ideographic Space in current window.
"
":ZenSpaceList					*:ZenSpaceList*
"	Respects 'list' option to show Ideographic Space.
"
":ZenSpaceUpdate					*:ZenSpaceUpdate*
"	Manually updates the showing state.  You don't need this usually.
"$BA43Q%9%Z!<%9I=<((B
Plugin 'enbunsui/vim-zenspace'
"$B9T0\F0(B
Plugin 'ywsrock/vim-move'
"Window $B%j%5%$%:(B
Plugin 'simeji/winresizer'

"Language Servers :LspInstallServer
"default $HOME/.local/share/vim-lsp-settings/servers
Plugin 'prabirshrestha/vim-lsp'
Plugin 'mattn/vim-lsp-settings'

"Auto-complete
Plugin 'prabirshrestha/asyncomplete.vim'
Plugin 'prabirshrestha/asyncomplete-lsp.vim'
"Plug 'Shougo/ddc.vim'
"Plug 'shun/ddc-vim-lsp'


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

" If you have vim >=8.0 or Neovim >= 0.1.5
if (has("termguicolors"))
 set termguicolors
endif


"$BH>3QJ8;z$N@_Dj(B
set guifont=MS_Gothic:h9
"$BA43QJ8;z$N@_Dj(B
set guifontwide=MS_Gothic:h9
set spell 
set spelllang=en_us,cjk
set complete+=kspell

set nu
set hlsearch
set ignorecase
set smartcase
set cursorline
set showmode
set autoindent
set showmatch
set encoding=utf-8
set incsearch
set fileencodings=iso-2022-jp,ucs-bom,sjis,utf-8,euc-jp,cp932,default,latin1
syntax on
set wildmenu
set wildmode=list,full



set tabstop=2          "$B%?%V$r2?J8;z$N6uGr$KJQ49$9$k$+(B
set shiftwidth=2       "$B<+F0%$%s%G%s%H;~$KF~NO$9$k6uGr$N?t(B
set expandtab          "$B%?%VF~NO$r6uGr$KJQ49(B
set splitright         "$B2hLL$r=DJ,3d$9$k:]$K1&$K3+$/(B
set clipboard=unnamed  "yank $B$7$?J8;zNs$r%/%j%C%W%\!<%I$K%3%T!<(B
colorscheme onedark
let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ }
let g:move_key_modifier = 'C'


"$BA43QI=<((B
let g:zenspace#default_mode = 'on'
"Indent$BM-8z(B
"let g:indent_guides_auto_colors = 0
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
"Alternatively you can add the following lines to your colorscheme file.
"hi IndentGuidesOdd  guibg=red   ctermbg=3
"hi IndentGuidesEven guibg=green ctermbg=4
let g:indent_guides_enable_on_vim_startup = 1


hi NonText    ctermbg=None ctermfg=59 guibg=NONE guifg=None
hi SpecialKey ctermbg=None ctermfg=59 guibg=NONE guifg=None

set guifont=Menlo\ Regular:h14
set laststatus=2

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

let g:mapleader = ","

"LSP key map
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
  augroup END


