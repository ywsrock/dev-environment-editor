" =============================================================================
" plugins.vim - Vundle プラグイン定義
" =============================================================================

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

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

" -----------------------------------------------------------------------------
" Git
" -----------------------------------------------------------------------------
Plugin 'sindrets/diffview.nvim'          " git差分表示

" -----------------------------------------------------------------------------
" LSP / 補完
" -----------------------------------------------------------------------------
Plugin 'neoclide/coc.nvim', {'branch': 'release'}

" -----------------------------------------------------------------------------
" Markdown
" -----------------------------------------------------------------------------
Plugin 'godlygeek/tabular'
Plugin 'preservim/vim-markdown'
Plugin 'iamcco/markdown-preview.nvim'

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

call vundle#end()
filetype plugin indent on
