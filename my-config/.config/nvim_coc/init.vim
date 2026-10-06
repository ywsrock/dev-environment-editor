" =============================================================================
" init.vim - Neovim 設定エントリーポイント
" =============================================================================
" 
" 構成:
"   ~/.config/nvim/
"   ├── init.vim                 # このファイル（エントリーポイント）
"   ├── plugin/
"   │   ├── plugins.vim          # Vundle プラグイン定義
"   │   ├── options.vim          # 基本設定
"   │   ├── keymaps.vim          # キーマッピング
"   │   ├── coc.vim              # coc.nvim 設定
"   │   ├── fzf.vim              # fzf 設定
"   │   ├── startify.vim         # startify 設定
"   │   └── vscode.vim           # VSCode 用設定
"   ├── lua/plugins/
"   │   └── noice.lua            # noice + notify 設定
"   └── plugins/                 # 言語別設定（既存）
"       ├── go/format.vim
"       └── python/format.vim
"
" =============================================================================

" -----------------------------------------------------------------------------
" 重要: mapleader は最初に定義する（他のマッピングより前）
" -----------------------------------------------------------------------------
let g:mapleader = ","

" -----------------------------------------------------------------------------
" 起動時のプロジェクトルートを保存（autochdir より前）
" -----------------------------------------------------------------------------
let g:project_root = getcwd()

" -----------------------------------------------------------------------------
" Lua プラグイン初期化
" -----------------------------------------------------------------------------
" アニメーションカーソル
lua require('smear_cursor').enabled = true

" コメント
lua require('Comment').setup()

" noice + notify
lua require('plugins.noice')

" インデントガイド（VSCode以外）
if !exists('g:vscode')
  let g:indent_guides_enable_on_vim_startup = 1
endif

" -----------------------------------------------------------------------------
" カラースキーム
" -----------------------------------------------------------------------------
colorscheme tokyonight

" アクティブウィンドウの背景色
highlight Normal guibg=#1e1e2e

" 非アクティブウィンドウの背景色
highlight NormalNC guibg=#282838

" colorscheme 再読み込み時にも維持する
augroup MyHighlights
  autocmd!
  autocmd ColorScheme * highlight Normal guibg=#1e1e2e | highlight NormalNC guibg=#282838
augroup END

" lightline カラースキーム
let g:lightline = {'colorscheme': 'tokyonight'}

" その他のハイライト
hi NonText ctermbg=NONE ctermfg=59 guibg=NONE guifg=NONE
hi SpecialKey ctermbg=NONE ctermfg=59 guibg=NONE guifg=NONE
hi CursorLine gui=underline cterm=underline

" -----------------------------------------------------------------------------
" 言語別設定
" -----------------------------------------------------------------------------
augroup filetype_settings
  autocmd!
  " Go
  autocmd FileType go source ~/.config/nvim/plugins/go/format.vim
  " Python
  autocmd FileType python source ~/.config/nvim/plugins/python/format.vim
augroup END
