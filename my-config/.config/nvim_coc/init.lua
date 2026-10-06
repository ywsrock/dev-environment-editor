-- =============================================================================
-- init.lua - Neovim 設定エントリーポイント (lazy.nvim)
-- =============================================================================
--
-- 構成:
--   ~/.config/nvim/
--   ├── init.lua                 # このファイル（エントリーポイント）
--   ├── lua/
--   │   ├── config/
--   │   │   ├── options.lua      # 基本設定
--   │   │   ├── keymaps.lua      # キーマッピング
--   │   │   └── autocmds.lua     # autocmd 設定
--   │   └── plugins/             # lazy.nvim プラグイン設定
--   │       ├── colorscheme.lua
--   │       ├── ui.lua
--   │       ├── editor.lua
--   │       ├── coc.lua
--   │       ├── search.lua
--   │       ├── git.lua
--   │       ├── noice.lua
--   │       ├── markdown.lua
--   │       ├── terminal.lua
--   │       └── utils.lua
--   ├── plugin/
--   │   └── vscode.vim           # VSCode 用設定
--   └── plugins/                 # 言語別設定（既存）
--       ├── go/format.vim
--       └── python/format.vim
--
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 重要: mapleader は最初に定義する（他のマッピングより前）
-- -----------------------------------------------------------------------------
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- -----------------------------------------------------------------------------
-- 起動時のプロジェクトルートを保存（autochdir より前）
-- -----------------------------------------------------------------------------
vim.g.project_root = vim.fn.getcwd()

-- -----------------------------------------------------------------------------
-- lazy.nvim ブートストラップ
-- -----------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- -----------------------------------------------------------------------------
-- 設定ファイル読み込み
-- -----------------------------------------------------------------------------
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- -----------------------------------------------------------------------------
-- lazy.nvim プラグイン読み込み
-- -----------------------------------------------------------------------------
require("lazy").setup("plugins", {
  defaults = {
    lazy = true,  -- デフォルトで遅延読み込み
  },
  install = {
    colorscheme = { "tokyonight" },
  },
  checker = {
    enabled = false,  -- 自動更新チェック無効
  },
  change_detection = {
    notify = false,   -- 設定変更時の通知無効
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
