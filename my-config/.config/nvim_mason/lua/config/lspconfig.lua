-- =============================================================================
-- lspconfig.lua - LSP 設定 + キーマップ（Neovim 0.11+ 対応）
-- =============================================================================

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- -----------------------------------------------------------------------------
-- キーマップ設定（coc.vim と同じ）
-- -----------------------------------------------------------------------------
local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  local keymap = vim.keymap.set

  -- ナビゲーション（coc.vim と同じ）
  keymap("n", "gd", vim.lsp.buf.definition, opts)           -- 定義へジャンプ
  keymap("n", "gy", vim.lsp.buf.type_definition, opts)      -- 型定義
  keymap("n", "gi", vim.lsp.buf.implementation, opts)       -- 実装へ
  keymap("n", "gr", vim.lsp.buf.references, opts)           -- 参照一覧

  -- ドキュメント（coc.vim と同じ）
  keymap("n", "K", vim.lsp.buf.hover, opts)                 -- ドキュメント表示

  -- 診断メッセージ間を移動（coc.vim: [g ]g）
  keymap("n", "[g", vim.diagnostic.goto_prev, opts)
  keymap("n", "]g", vim.diagnostic.goto_next, opts)

  -- リファクタリング（coc.vim と同じ）
  keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)       -- リネーム
  keymap("n", "<leader>ac", vim.lsp.buf.code_action, opts)  -- コードアクション
  keymap("n", "<leader>a", vim.lsp.buf.code_action, opts)   -- コードアクション（選択）
  keymap("v", "<leader>a", vim.lsp.buf.code_action, opts)

  -- フォーマット（conform.nvim で処理するが、LSP フォールバックも設定）
  keymap("n", "<leader>f", function()
    vim.lsp.buf.format({ async = true })
  end, opts)
  keymap("v", "<leader>f", function()
    vim.lsp.buf.format({ async = true })
  end, opts)

  -- シンボルハイライト（カーソル位置）
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_autocmd("CursorHold", {
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

-- -----------------------------------------------------------------------------
-- LSP サーバー設定（Neovim 0.11+ vim.lsp.config API）
-- -----------------------------------------------------------------------------
local servers = {
  "jsonls",
  "ts_ls",
  "pyright",
  "eslint",
  "cssls",
  "html",
  "yamlls",
  "taplo",
  "gopls",
  "rust_analyzer",
  "bashls",
  "vimls",
  "dockerls",
  "lemminx",
  -- "jdtls",
  "perlnavigator",
  "powershell_es",
  "vuels",
}

-- Neovim 0.11+ の vim.lsp.config を使用
for _, server in ipairs(servers) do
  vim.lsp.config[server] = {
    capabilities = capabilities,
    on_attach = on_attach,
  }
end

-- LSP を有効化
vim.lsp.enable(servers)

-- -----------------------------------------------------------------------------
-- 診断表示設定
-- -----------------------------------------------------------------------------
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
  },
})

-- 診断アイコン
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- -----------------------------------------------------------------------------
-- CocList 相当のキーマップ（Telescope 連携）
-- -----------------------------------------------------------------------------
local telescope_ok, telescope = pcall(require, "telescope.builtin")
if telescope_ok then
  vim.keymap.set("n", "<space>a", function() vim.diagnostic.setloclist() end, { desc = "Diagnostics" })
  vim.keymap.set("n", "<space>o", telescope.lsp_document_symbols, { desc = "Outline" })
  vim.keymap.set("n", "<space>s", telescope.lsp_workspace_symbols, { desc = "Symbols" })
end
