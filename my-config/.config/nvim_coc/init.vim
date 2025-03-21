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
Plugin 'neoclide/coc.nvim', {'branch': 'release'}

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

" notice ambiwidth指定できないので、コメントアウト
"Plugin 'folke/noice.nvim'
"Plugin 'MunifTanjim/nui.nvim'
"Plugin 'rcarriga/nvim-notify', 

" gitファイル差分表示
Plugin 'sindrets/diffview.nvim'
" ファイルアイコン表示
Plugin 'nvim-tree/nvim-web-devicons'

call vundle#end()            " required
" All of your Plugins must be added before the following line
filetype plugin indent on    " required

"" noice設定-----
"lua << EOF
"require("noice").setup({
"routes = {
"  {
"      view = "notify",
"      filter = { event = "msg_showmode" },
"  },
"},  
"views = {
"  cmdline_popup = {
"    position = {
"      row = 5,
"      col = "50%",
"    },
"    size = {
"      width = 60,
"      height = "auto",
"    },
"  },
"  popupmenu = {
"    relative = "editor",
"    position = {
"      row = 8,
"      col = "50%",
"    },
"    size = {
"      width = 60,
"      height = 10,
"    },
"    border = {
"      style = "rounded",
"      padding = { 0, 1 },
"    },
"    win_options = {
"      winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
"    },
"  },
"  },
"})
"EOF


" カラースキーム設定
if (has("termguicolors"))
  set termguicolors
endif

if !exists("g:neovide")
  " フォント設定
 "set guifont=MS_Gothic:h9
 set guifontwide=MS_Gothic:h9
 set guifont=Menlo\ Regular:h14
endif

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
  let g:floaterm_wintype = 'float'
  let g:floaterm_position = 'bottomright'
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
set ambiwidth=double

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
 set laststatus=2


" キーマッピング
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

let g:mapleader = ","

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


" diffview設定
":DiffviewClose: Close the current diffview. You can also use :tabclose.
":DiffviewToggleFiles: Toggle the file panel.
":DiffviewFocusFiles: Bring focus to the file panel.
":DiffviewRefresh: Update stats and entries in the file list of the current Diffview.
nnoremap <leader>gd :DiffviewOpen<CR>
nnoremap <leader>gD :DiffviewClose<CR>
nnoremap <leader>gh :DiffviewFileHistory<CR>
nnoremap <leader>gH :DiffviewFileHistory %<CR>

" Go ファイルのフォーマット設定を有効にする
augroup go_format
  autocmd!
  autocmd FileType go source ~/.config/nvim/plugins/go/format.vim
augroup END

" Python ファイルのフォーマットを有効にする
augroup python_format
  autocmd!
  autocmd FileType python source ~/.config/nvim/plugins/python/format.vim
augroup END

"---------
" https://raw.githubusercontent.com/neoclide/coc.nvim/refs/heads/master/doc/coc-example-config.vim

" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" utf-8 byte sequence
set encoding=utf-8
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" coc will install the missing extensions after coc.nvim service started.
let g:coc_global_extensions = [
  \ 'coc-calc',
  \ 'coc-cfn-lint',
  \ 'coc-css',
  \ 'coc-diagnostic',
  \ 'coc-docker',
  \ 'coc-eslint',
  \ 'coc-fzf-preview',
  \ 'coc-git',
  \ 'coc-go',
  \ 'coc-golines',
  \ 'coc-html',
  \ 'coc-htmlhint',
  \ 'coc-java',
  \ 'coc-jedi',
  \ 'coc-json',
  \ 'coc-markdownlint',
  \ 'coc-perl',
  \ 'coc-powershell',
  \ 'coc-prettier',
  \ 'coc-pyright',
  \ 'coc-rust-analyzer',
  \ 'coc-sh',
  \ 'coc-snippets',
  \ 'coc-spell-checker',
  \ 'coc-sql',
  \ 'coc-sqlfluff',
  \ 'coc-toml',
  \ 'coc-tsserver',
  \ 'coc-vetur',
  \ 'coc-vimlsp',
  \ 'coc-xml',
  \ 'coc-yaml'
  \ ]

" vscode の場合、Cocを無効にする
if has('vscode')
  let g:coc_start_at_startup = 0
endif

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>ra  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>ra  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
"------
