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
"   │   ├── fzf.vim              # fzf 設定
"   │   ├── startify.vim         # startify 設定
"   │   └── vscode.vim           # VSCode 用設定
"   ├── lua/config/
"   │   ├── mason.lua            # LSP サーバー管理
"   │   ├── lspconfig.lua        # LSP 設定 + キーマップ
"   │   ├── cmp.lua              # 補完
"   │   ├── conform.lua          # フォーマッター
"   │   └── treesitter.lua       # treesitter 設定
"   └── lua/plugins/
"       ├── noice.lua            # noice + notify 設定
"       ├── telescope.lua        # telescope 設定
"       └── md_preview.lua       # nvim-md-preview 設定
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

" コメント（Comment.nvim）
" ショートカット:
"   gcc         現在行をコメント/アンコメント
"   gbc         現在行をブロックコメント
"   gc{motion}  モーションで指定した範囲をコメント
"   gb{motion}  モーションで指定した範囲をブロックコメント
"   gcO         上の行にコメント行を追加
"   gco         下の行にコメント行を追加
"   gcA         行末にコメントを追加
"   gc (Visual) 選択範囲をコメント/アンコメント
"   gb (Visual) 選択範囲をブロックコメント
lua require('Comment').setup()

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
lua require('config.cmp')
lua require('config.conform')

" Treesitter（シンタックスハイライト強化・コード解析）
" ショートカット: <CR> 選択開始/拡大, af/if 関数選択, ]m/[m 関数移動
lua require('config.treesitter')

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

