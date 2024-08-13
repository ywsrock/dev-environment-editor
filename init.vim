" 基本設定
set nocompatible              " 必須
filetype off                  " 必須
set rtp+=~/.vim/bundle/Vundle.vim

" Vundle初期化
call vundle#begin()

" プラグイン管理
" Vundle管理、必須
Plugin 'VundleVim/Vundle.vim'
" YAML用フォールド
Plugin 'pedrohdz/vim-yaml-folds'
" ブックマーク
Plugin 'kshenoy/vim-signature'
" ステータスバー表示
Plugin 'itchyny/lightline.vim'
" ファイルエクスプローラー
Plugin 'preservim/nerdtree'
" インデントガイド
Plugin 'nathanaelkane/vim-indent-guides'
" カラースキーム
Plugin 'joshdick/onedark.vim'
Plugin 'EdenEast/nightfox.nvim'
Plugin 'folke/tokyonight.nvim'
Plugin 'arcticicestudio/nord-vim'
" 全角スペース表示
Plugin 'enbunsui/vim-zenspace'
" 行移動
Plugin 'ywsrock/vim-move'
" ウィンドウリサイズ
Plugin 'simeji/winresizer'
" quickfixプレビュー
Plugin 'ronakg/quickr-preview.vim'
" Language Servers
Plugin 'prabirshrestha/vim-lsp'
Plugin 'mattn/vim-lsp-settings'
" 自動補完
Plugin 'prabirshrestha/asyncomplete.vim'
Plugin 'prabirshrestha/asyncomplete-lsp.vim'
Plugin 'prabirshrestha/asyncomplete-gocode.vim'
Plugin 'high-moctane/asyncomplete-nextword.vim'
" Markdownハイライト
Plugin 'godlygeek/tabular'
Plugin 'preservim/vim-markdown'
Plugin 'iamcco/markdown-preview.nvim'
" フロートウィンドウ
Plugin 'voldikss/vim-floaterm'
" fzf
"Plugin 'junegunn/fzf'
Plugin 'nvim-lua/plenary.nvim'
Plugin 'nvim-telescope/telescope.nvim'
" 翻訳
Plugin 'voldikss/vim-translator'

" notice
Plugin 'folke/noice.nvim'
Plugin 'MunifTanjim/nui.nvim'
Plugin 'rcarriga/nvim-notify', 

call vundle#end()            " required
" All of your Plugins must be added before the following line
  filetype plugin indent on    " required

" noice設定
lua << EOF
require("noice").setup({
  views = {
    cmdline_popup = {
      position = {
        row = 5,
        col = "50%",
      },
      size = {
        width = 60,
        height = "auto",
      },
    },
    popupmenu = {
      relative = "editor",
      position = {
        row = 8,
        col = "50%",
      },
      size = {
        width = 60,
        height = 10,
      },
      border = {
        style = "rounded",
        padding = { 0, 1 },
      },
      win_options = {
        winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
      },
    },
  },
})
EOF

" カラースキーム設定
if (has("termguicolors"))
  set termguicolors
endif

" フォント設定
set guifont=MS_Gothic:h9
set guifontwide=MS_Gothic:h9

if !exists('g:vscode')
  set spell
  let g:floaterm_keymap_new = '<Leader>fc'
  let g:floaterm_keymap_prev = '<Leader>fp'
  let g:floaterm_keymap_next = '<Leader>fn'
  let g:floaterm_keymap_first= '<Leader>f^'
  let g:floaterm_keymap_last = '<Leader>f$'
  let g:floaterm_keymap_hide = '<Leader>fh'
  let g:floaterm_keymap_show = '<Leader>fs'
  let g:floaterm_keymap_kill = '<Leader>fk'
  let g:floaterm_keymap_toggle= '<Leader>ft'
  let g:indent_guides_enable_on_vim_startup = 1
endif

" その他の設定
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
set foldnestmax=10
set nofoldenable
set foldlevel=2
set backspace=2
set belloff=all

" タブとインデント設定
set tabstop=2
set shiftwidth=2
set expandtab
set splitright
set clipboard=unnamedplus
"set ambiwidth=double

" 行番号の表示と検索ハイライト解除
nnoremap <ESC><ESC> :nohlsearch<CR>

" カラースキーム
colorscheme tokyonight
" lightline設定
let g:lightline = {'colorscheme': 'tokyonight'}

" その他のハイライト設定
hi NonText ctermbg=NONE ctermfg=59 guibg=NONE guifg=NONE
hi SpecialKey ctermbg=NONE ctermfg=59 guibg=NONE guifg=NONE
hi CursorLine gui=underline cterm=underline


" フォント設定
set guifont=Menlo\ Regular:h14
set laststatus=2

" キーマッピング
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

let g:mapleader = ","

" LSP キーマッピング
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
    let g:lsp_document_highlight_enabled = 1
    highlight lspReference ctermfg=green guifg=green
endfunction

augroup lsp_install
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" quickfix プレビュー キーマッピング
let g:quickr_preview_keymaps = 0
nmap gs <plug>(quickr_preview)
nmap gc <plug>(quickr_preview_qf_close)
let g:quickr_preview_position = 'right'

" Markdownプレビュー キーマッピング
nmap <leader>gs <Plug>MarkdownPreview
nmap <leader>gc <Plug>MarkdownPreviewStop
nmap <leader>gt <Plug>MarkdownPreviewToggle
let g:mkdp_command_for_global = 1

" fzf キーマッピング
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" VSCode用設定
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

nmap <leader>cp :Copilot panel<CR>
imap <C-j> <Plug>(copilot-next)
imap <C-k> <Plug>(copilot-previous)
imap <C-l> <Plug>(copilot-accept-word)

" 翻訳設定
let g:translator_target_lang = 'ja'
nmap <silent> <Leader>t <Plug>Translate
vmap <silent> <Leader>t <Plug>TranslateV
nmap <silent> <Leader>w <Plug>TranslateW
vmap <silent> <Leader>w <Plug>TranslateWV
nmap <silent> <Leader>r <Plug>TranslateR
vmap <silent> <Leader>r <Plug>TranslateRV
nmap <silent> <Leader>x <Plug>TranslateX
nnoremap <silent><expr> <M-f> translator#window#float#has_scroll() ?
                            \ translator#window#float#scroll(1) : "\<M-f>"
nnoremap <silent><expr> <M-b> translator#window#float#has_scroll() ?
                            \ translator#window#float#scroll(0) : "\<M-b>"

