-- =============================================================================
-- mason.lua - LSP サーバー管理
-- =============================================================================

require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

require("mason-lspconfig").setup({
  -- 自動インストールする LSP サーバー（旧 coc-extensions に対応）
  ensure_installed = {
    -- 基本
    "jsonls",           -- coc-json
    "ts_ls",            -- coc-tsserver (TypeScript/JavaScript)
    "pyright",          -- coc-pyright
    "eslint",           -- coc-eslint

    -- Web
    "cssls",            -- coc-css
    "html",             -- coc-html

    -- 設定ファイル
    "yamlls",           -- coc-yaml
    "taplo",            -- coc-toml

    -- 言語
    "gopls",            -- coc-go
    "rust_analyzer",    -- coc-rust-analyzer
    "bashls",           -- coc-sh
    "vimls",            -- coc-vimlsp
    "dockerls",         -- coc-docker
    "lemminx",          -- coc-xml
    -- "jdtls",            -- coc-java
    "perlnavigator",    -- coc-perl
    "powershell_es",    -- coc-powershell
    "vuels",            -- coc-vetur
  },

  -- 自動ハンドラー（インストール済み LSP を自動設定）
  automatic_installation = true,
})
