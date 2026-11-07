" =============================================================================
" init.vim - Neovim 設定エントリーポイント
" =============================================================================
"
" 構成:
"   ~/.config/nvim/
"   ├── init.vim                 # このファイル（エントリーポイント）
"   ├── README.md                # セットアップ手順・キー操作・LSP 追加手順
"   ├── plugin/
"   │   ├── plugins.vim          # Vundle プラグイン定義
"   │   ├── options.vim          # 基本設定
"   │   ├── keymaps.vim          # キーマッピング
"   │   ├── fzf.vim              # fzf 設定
"   │   ├── startify.vim         # startify 設定
"   │   └── vscode.vim           # VSCode 用設定
"   ├── lua/config/
"   │   ├── mason.lua            # LSP サーバー管理（LSP 追加時はここに追加）
"   │   ├── lspconfig.lua        # LSP 共通設定 + キーマップ
"   │   ├── diagnostic.lua       # 診断の表示設定 + gl / <space>ta
"   │   ├── cmp.lua              # 補完
"   │   ├── conform.lua          # フォーマッター
"   │   └── treesitter.lua       # treesitter 設定
"   ├── lua/plugins/
"   │   ├── noice.lua            # noice + notify 設定
"   │   ├── telescope.lua        # telescope 設定
"   │   └── md_preview.lua       # nvim-md-preview 設定
"   └── after/lsp/               # LSP サーバー個別設定（自動で読み込み・マージ）
"       ├── rust_analyzer.lua    # Rust
"       ├── lua_ls.lua           # Lua
"       └── omnisharp.lua        # C#
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
" プラグイン読み込み（Vundle）
" plugin/ ディレクトリは自動読み込みされるが、Vundle は最初に必要
" -----------------------------------------------------------------------------
"source ~/.config/nvim/plugin/plugins.vim
" windowsの場合は以下のようにする
" source $HOME/AppData/Local/nvim/plugin/plugins.vim
" windowsの場合
if has('win32') || has('win64')
  source $HOME/AppData/Local/nvim/plugin/plugins.vim
else
  source ~/.config/nvim/plugin/plugins.vim
endif

" -----------------------------------------------------------------------------
" Lua プラグイン初期化
" -----------------------------------------------------------------------------
" アニメーションカーソル
lua require('smear_cursor').enabled = true

" コメント（Neovim 標準機能。プラグイン不要）
" ※ Comment.nvim は Neovim 0.12 の Treesitter に未対応で Rust / TS 等で動かないため削除
" ショートカット:
"   gcc         現在行をコメント/アンコメント
"   gc{motion}  モーションで指定した範囲をコメント（例: gcj, gcip）
"   gc (Visual) 選択範囲をコメント/アンコメント

" noice + notify
lua require('plugins.noice')

" Markdown プレビュー（nvim-md-preview）
lua require('plugins.md_preview')

" -----------------------------------------------------------------------------
" LSP / 補完設定（Neovim 標準 LSP + nvim-cmp）
" mason → lspconfig → cmp → conform の順で読み込む
" -----------------------------------------------------------------------------
lua require('config.mason')
lua require('config.lspconfig')
lua require('config.diagnostic')
lua require('config.cmp')
lua require('config.conform')

" Treesitter（シンタックスハイライト強化・コード解析）
" ショートカット: <CR> 選択開始/拡大, af/if 関数選択, ]m/[m 関数移動
lua require('config.treesitter')

" インデントガイド（VSCode以外）
if !exists('g:vscode')
  let g:indent_guides_enable_on_vim_startup = 1
  " 通常ファイル以外（terminal / nofile / prompt / quickfix 等）には表示しない
  " → fzf（terminal）や Telescope（prompt / nofile）の縦縞を防ぐ
  let g:indent_guides_exclude_buftype = 1
  let g:indent_guides_exclude_filetypes = [
        \ 'help', 'fzf', 'TelescopePrompt', 'TelescopeResults',
        \ 'nerdtree', 'startify', 'floaterm', 'noice', 'notify' ]
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

