set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim


"：BundleInstall！ -すべてのプラグインを更新
"：BundleSearch foo-fooプラグインを検索
"：バンドル検索！ foo-fooプラグインのバッファを更新する
"：BundleClean-プラグインが.vimrcで定義されていない場合、すべてのプラグインをクリーンアップします
call vundle#begin()

"VIM-YAML-FOLDS
Plugin 'pedrohdz/vim-yaml-folds'
"bookmark
Plugin 'kshenoy/vim-signature'
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
"スタータスバー表示
Plugin 'itchyny/lightline.vim'
"エクスプローラー
Plugin 'preservim/nerdtree'

":IndentGuidesEnable
":IndentGuidesDisable
":IndentGuidesToggle
"let g:indent_guides_enable_on_vim_startup = 1
"インデントを可視化する
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
"全角スペース表示
Plugin 'enbunsui/vim-zenspace'
"行移動
Plugin 'ywsrock/vim-move'
"Window リサイズ
Plugin 'simeji/winresizer'
"quickfix preview
Plugin 'ronakg/quickr-preview.vim'

"Language Servers :LspInstallServer
"default $HOME/.local/share/vim-lsp-settings/servers
Plugin 'prabirshrestha/vim-lsp'
Plugin 'mattn/vim-lsp-settings'

"Auto-complete
Plugin 'prabirshrestha/asyncomplete.vim'
Plugin 'prabirshrestha/asyncomplete-lsp.vim'
"Plug 'Shougo/ddc.vim'
"Plug 'shun/ddc-vim-lsp'
"markdown highlight
Plugin 'godlygeek/tabular'
Plugin 'preservim/vim-markdown'
"
"call mkdp#util#install()
Plugin 'iamcco/markdown-preview.nvim'


call vundle#end()            " required
" All of your Plugins must be added before the following line
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


"半角文字の設定
set guifont=MS_Gothic:h9
"全角文字の設定
set guifontwide=MS_Gothic:h9
set spell 
set spelllang=en_us,cjk
set complete+=kspell

set nu
set hlsearch
set ignorecase
set smartcase
set cursorline
set showcmd
set showmode
set autoindent
set autochdir
set showmatch
set encoding=utf-8
set incsearch
set fileencodings=iso-2022-jp,ucs-bom,sjis,utf-8,euc-jp,cp932,default,latin1
syntax on
set wildmenu
set wildmode=list,full
set foldmethod=indent
set backspace=2
set belloff=all

set tabstop=2          "タブを何文字の空白に変換するか
set shiftwidth=2       "自動インデント時に入力する空白の数
set expandtab          "タブ入力を空白に変換
set splitright         "画面を縦分割する際に右に開く
set clipboard=unnamedplus  "yank した文字列をクリップボードにコピー
colorscheme onedark

let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ }
let g:move_key_modifier = 'C'

autocmd QuickFixCmdPost *grep* cwindow

"全角表示
let g:zenspace#default_mode = 'on'
"Indent有効
"let g:indent_guides_auto_colors = 0
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
"Alternatively you can add the following lines to your colorscheme file.
"hi IndentGuidesOdd  guibg=red   ctermbg=3
"hi IndentGuidesEven guibg=green ctermbg=4
let g:indent_guides_enable_on_vim_startup = 1


hi NonText    ctermbg=NONE ctermfg=59 guibg=NONE guifg=NONE
hi SpecialKey ctermbg=NONE ctermfg=59 guibg=NONE guifg=NONE
hi CursorLine gui=underLine cterm=underLine

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
    nmap <buffer> <leader>dia <plug>(lsp-document-diagnostics)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.* call execute('LspDocumentFormatSync')
    "Highlight references
    let g:lsp_document_highlight_enabled = 1
    highlight lspReference ctermfg=green guifg=grenn
    "highlight lspReference ctermfg=white guifg=white ctermbg=green guibg=green
    " refer to doc to add more commands
endfunction

augroup lsp_install
  au!
  " call s:on_lsp_buffer_enabled only for languages that has the server registered.
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
  augroup END

"Quickix Preview key map
let g:quickr_preview_keymaps = 0

nmap gs <plug>(quickr_preview)
nmap gc <plug>(quickr_preview_qf_close)
"above, below, left, or right
let g:quickr_preview_position = 'right'



"marddownPrew
" set to 1, nvim will open the preview window after entering the Markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when changing
" from Markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1
" combine preview window
" default: 0
" if enable it will reuse previous opened preview window when you preview markdown file.
" ensure to set let g:mkdp_auto_close = 0 if you have enable this option
let g:mkdp_combine_preview = 0

" auto refetch combine preview contents when change markdown buffer
" only when g:mkdp_combine_preview is 1
let g:mkdp_combine_preview_auto_refresh = 1

nmap <leader>gs <Plug>MarkdownPreview
nmap <leader>gr <Plug>MarkdownPreviewStop
nmap <leader>gt <Plug>MarkdownPreviewToggle
