set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim


"：BundleInstall！ -すべてのプラグインを更新
"：BundleSearch foo-fooプラグインを検索
"：バンドル検索！ foo-fooプラグインのバッファを更新する
"：BundleClean-プラグインが.vimrcで定義されていない場合、すべてのプラグインをクリーンアップします
call vundle#begin()

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
set showmode
set autoindent
set showmatch
set encoding=utf-8
set incsearch
set fileencodings=iso-2022-jp,ucs-bom,sjis,utf-8,euc-jp,cp932,default,latin1
syntax on
set wildmenu
set wildmode=list,full



set tabstop=2          "タブを何文字の空白に変換するか
set shiftwidth=2       "自動インデント時に入力する空白の数
set expandtab          "タブ入力を空白に変換
set splitright         "画面を縦分割する際に右に開く
set clipboard=unnamed  "yank した文字列をクリップボードにコピー
set autochdir          "作業ディレクトリ自動変更

set foldmethod=indent  "折りたたみ範囲の判断基準（デフォルト: manual）
set foldlevel=2        "ファイルを開いたときにデフォルトで折りたたむレベル
set foldcolumn=3       "左端に折りたたみ状態を表示する領域を追加する

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

"Quickix Preview key map
let g:quickr_preview_keymaps = 0

nmap gs <plug>(quickr_preview)
nmap gc <plug>(quickr_preview_qf_close)
"above, below, left, or right
let g:quickr_preview_position = 'right'
