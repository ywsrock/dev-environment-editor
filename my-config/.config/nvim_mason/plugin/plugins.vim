" =============================================================================
" plugins.vim - Vundle プラグイン定義（Windows/Linux クロスプラットフォーム対応）
" =============================================================================

set nocompatible
filetype off

" クロスプラットフォーム対応: Vundle パス
if has('win32') || has('win64')
  set rtp+=~/vimfiles/bundle/Vundle.vim
  call vundle#begin('~/vimfiles/bundle')
else
  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#begin()
endif

" -----------------------------------------------------------------------------
" プラグイン管理
" -----------------------------------------------------------------------------
Plugin 'VundleVim/Vundle.vim'

" -----------------------------------------------------------------------------
" UI / 表示
" -----------------------------------------------------------------------------
Plugin 'itchyny/lightline.vim'           " ステータスバー
Plugin 'preservim/nerdtree'              " ファイルエクスプローラー
Plugin 'nathanaelkane/vim-indent-guides' " インデントガイド
Plugin 'nvim-tree/nvim-web-devicons'     " ファイルアイコン
Plugin 'ryanoasis/vim-devicons'          " ファイルアイコン（Vimscript版、startify連携用）
Plugin 'enbunsui/vim-zenspace'           " 全角スペース表示
Plugin 'sphamba/smear-cursor.nvim'       " アニメーションカーソル

" -----------------------------------------------------------------------------
" カラースキーム
" -----------------------------------------------------------------------------
Plugin 'joshdick/onedark.vim'
Plugin 'EdenEast/nightfox.nvim'
Plugin 'folke/tokyonight.nvim'
Plugin 'arcticicestudio/nord-vim'

" -----------------------------------------------------------------------------
" エディタ機能
" -----------------------------------------------------------------------------
Plugin 'kshenoy/vim-signature'           " ブックマーク
Plugin 'ywsrock/vim-move'                " 行移動
Plugin 'simeji/winresizer'               " ウィンドウリサイズ
Plugin 'numToStr/Comment.nvim'           " コメント

" -----------------------------------------------------------------------------
" 検索 / ファジーファインダー
" -----------------------------------------------------------------------------
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'
Plugin 'nvim-lua/plenary.nvim'
Plugin 'nvim-telescope/telescope.nvim'
" Plugin 'nvim-telescope/telescope-file-browser.nvim'

" -----------------------------------------------------------------------------
" Git
" -----------------------------------------------------------------------------
Plugin 'sindrets/diffview.nvim'          " git差分表示

" -----------------------------------------------------------------------------
" LSP / 補完（Neovim 標準 LSP + nvim-cmp）
" -----------------------------------------------------------------------------
" coc.nvim は削除（Node.js プロセス残留問題のため）
" Plugin 'neoclide/coc.nvim', {'branch': 'release'}

" LSP サーバー管理
Plugin 'williamboman/mason.nvim'
Plugin 'williamboman/mason-lspconfig.nvim'

" LSP 設定
Plugin 'neovim/nvim-lspconfig'

" 補完エンジン
Plugin 'hrsh7th/nvim-cmp'
Plugin 'hrsh7th/cmp-nvim-lsp'
Plugin 'hrsh7th/cmp-buffer'
Plugin 'hrsh7th/cmp-path'
Plugin 'hrsh7th/cmp-cmdline'

" スニペット
Plugin 'L3MON4D3/LuaSnip'
Plugin 'saadparwaiz1/cmp_luasnip'
Plugin 'rafamadriz/friendly-snippets'

" フォーマッター
Plugin 'stevearc/conform.nvim'

" LSP UI 改善
Plugin 'onsails/lspkind.nvim'

" -----------------------------------------------------------------------------
" Treesitter（シンタックスハイライト強化・コード解析）
" Neovim 0.12+ は main ブランチが必要（master は互換性なし）
" -----------------------------------------------------------------------------
Plugin 'nvim-treesitter/nvim-treesitter', {'branch': 'main', 'do': ':TSUpdate'}
Plugin 'nvim-treesitter/nvim-treesitter-textobjects', {'branch': 'main'}  " テキストオブジェクト拡張
Plugin 'nvim-treesitter/nvim-treesitter-context', {'branch': 'main'}      " 現在のコンテキスト表示
Plugin 'HiPhish/rainbow-delimiters.nvim'              " 虹色括弧

" -----------------------------------------------------------------------------
" Markdown
" -----------------------------------------------------------------------------
Plugin 'godlygeek/tabular'
Plugin 'preservim/vim-markdown'
" Plugin 'iamcco/markdown-preview.nvim'   " 旧版（コメントアウト）
Plugin 'selimacerbas/kitehost.nvim'       " mdkite依存（Pure Lua HTTPサーバー）
"Plugin 'selimacerbas/mdkite.nvim'         " 新Markdownプレビュー（privteブラウザのタブ名はファイル名でなたいため、自分のforkを使用）
Plugin 'ywsrock/mdkite.nvim'
" -----------------------------------------------------------------------------
" ターミナル / フロートウィンドウ
" -----------------------------------------------------------------------------
Plugin 'voldikss/vim-floaterm'

" -----------------------------------------------------------------------------
" UI拡張（Neovim専用）
" -----------------------------------------------------------------------------
Plugin 'folke/noice.nvim'
Plugin 'MunifTanjim/nui.nvim'
Plugin 'rcarriga/nvim-notify'

" -----------------------------------------------------------------------------
" ユーティリティ
" -----------------------------------------------------------------------------
Plugin 'voldikss/vim-translator'         " 翻訳
Plugin 'ronakg/quickr-preview.vim'       " quickfixプレビュー
Plugin 'pedrohdz/vim-yaml-folds'         " YAMLフォールド
Plugin 'mhinz/vim-startify'              " セッション管理
Plugin 'kamykn/spelunker.vim'            " スペルチェック（coc-spell-checker代替）

call vundle#end()
filetype plugin indent on
