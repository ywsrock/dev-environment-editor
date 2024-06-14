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
Plugin 'EdenEast/nightfox.nvim' " Vim-Plug
Plugin 'folke/tokyonight.nvim'
Plugin 'arcticicestudio/nord-vim'
"
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
Plugin 'prabirshrestha/asyncomplete-gocode.vim'
Plugin 'high-moctane/asyncomplete-nextword.vim'
"Plug 'Shougo/ddc.vim'
"Plug 'shun/ddc-vim-lsp'
"markdown highlight
Plugin 'godlygeek/tabular'
Plugin 'preservim/vim-markdown'
Plugin 'iamcco/markdown-preview.nvim'

"float window
Plugin 'voldikss/vim-floaterm'

"fzf
Plugin 'junegunn/fzf'


" translate
Plugin 'voldikss/vim-translator'


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
if !exists('g:vscode')
  set spell 

  "https://github.com/voldikss/vim-floaterm/blob/master/doc/floaterm.txt
  let g:floaterm_keymap_new = '<Leader>fc'
  let g:floaterm_keymap_prev = '<Leader>fp'
  let g:floaterm_keymap_next = '<Leader>fn'
  let g:floaterm_keymap_first= '<Leader>f^'
  let g:floaterm_keymap_last = '<Leader>f$'
  let g:floaterm_keymap_hide = '<Leader>fh'
  let g:floaterm_keymap_show = '<Leader>fs'
  let g:floaterm_keymap_kill = '<Leader>fk'
  let g:floaterm_keymap_toggl= '<Leader>ft'





"Indent有効
"let g:indent_guides_auto_colors = 0
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
"Alternatively you can add the following lines to your colorscheme file.
"hi IndentGuidesOdd  guibg=red   ctermbg=3
"hi IndentGuidesEven guibg=green ctermbg=4
  let g:indent_guides_enable_on_vim_startup = 1

endif

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
set fileencodings=utf-8,sjis,euc-jp,cp932,default,latin1,iso-2022-jp,ucs-bom
set fileformats=unix,dos,mac
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
set ambiwidth=double
"Autoreload files when changed externally
set autoread

"set fixendofline
set nofixendofline

nnoremap <ESC><ESC> :nohlsearch<CR>

"colorscheme Carbonfox
"colorscheme nightfox
"colorscheme onedark
"
colorscheme tokyonight

" There are also colorschemes for the different styles.
"colorscheme tokyonight-night
"colorscheme tokyonight-storm
"colorscheme tokyonight-day
"colorscheme tokyonight-moon


"let g:lightline = {'colorscheme': 'nightfox' }
let g:lightline = {'colorscheme': 'tokyonight' }
"
"let g:lightline = {'colorscheme': 'tokyonight'}
let g:move_key_modifier = 'C'

autocmd QuickFixCmdPost *grep* cwindow

"全角表示
let g:zenspace#default_mode = 'on'


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
nmap <leader>gs <Plug>MarkdownPreview
nmap <leader>gc <Plug>MarkdownPreviewStop
nmap <leader>gt <Plug>MarkdownPreviewToggle
" set to 1, the MarkdownPreview command can be used for all files,
" by default it can be use in Markdown files only
" default: 0
let g:mkdp_command_for_global = 1


"fzf
nmap <leader>ff :FZF<CR>

if exists('g:vscode')
    nnoremap <silent> za <Cmd>call VSCodeNotify('editor.toggleFold')<CR>
    nnoremap <silent> zR <Cmd>call VSCodeNotify('editor.unfoldAll')<CR>
    nnoremap <silent> zM <Cmd>call VSCodeNotify('editor.foldAll')<CR>
    nnoremap <silent> zo <Cmd>call VSCodeNotify('editor.unfold')<CR>
    nnoremap <silent> zO <Cmd>call VSCodeNotify('editor.unfoldRecursively')<CR>
    nnoremap <silent> zc <Cmd>call VSCodeNotify('editor.fold')<CR>
    nnoremap <silent> zC <Cmd>call VSCodeNotify('editor.foldRecursively')<CR>

    nnoremap <silent> z1 <Cmd>call VSCodeNotify('editor.foldLevel1')<CR>
    nnoremap <silent> z2 <Cmd>call VSCodeNotify('editor.foldLevel2')<CR>
    nnoremap <silent> z3 <Cmd>call VSCodeNotify('editor.foldLevel3')<CR>
    nnoremap <silent> z4 <Cmd>call VSCodeNotify('editor.foldLevel4')<CR>
    nnoremap <silent> z5 <Cmd>call VSCodeNotify('editor.foldLevel5')<CR>
    nnoremap <silent> z6 <Cmd>call VSCodeNotify('editor.foldLevel6')<CR>
    nnoremap <silent> z7 <Cmd>call VSCodeNotify('editor.foldLevel7')<CR>

    xnoremap <silent> zV <Cmd>call VSCodeNotify('editor.foldAllExcept')<CR>
endif

let g:copilot_filetypes = {
  \   '*': v:true,
  \}

" Copilot key map
nmap <leader>cp :Copilot panel<CR>
imap <C-j> <Plug>(copilot-next)
imap <C-k> <Plug>(copilot-previous)
imap <C-l> <Plug>(copilot-accept-word)




" translate config 
"https://github.com/voldikss/vim-translator?tab=readme-ov-file#installation
let g:translator_target_lang = 'ja'
" Echo translation in the cmdline
nmap <silent> <Leader>t <Plug>Translate
vmap <silent> <Leader>t <Plug>TranslateV
" Display translation in a window
nmap <silent> <Leader>w <Plug>TranslateW
vmap <silent> <Leader>w <Plug>TranslateWV
" Replace the text with translation
nmap <silent> <Leader>r <Plug>TranslateR
vmap <silent> <Leader>r <Plug>TranslateRV
" Translate the text in clipboard
nmap <silent> <Leader>x <Plug>TranslateX

nnoremap <silent><expr> <M-f> translator#window#float#has_scroll() ?
                            \ translator#window#float#scroll(1) : "\<M-f>"
nnoremap <silent><expr> <M-b> translator#window#float#has_scroll() ?
                            \ translator#window#float#scroll(0) : "\<M-b>"
