-- =============================================================================
-- conform.lua - フォーマッター（coc-prettier 等の代替）
-- =============================================================================

require("conform").setup({
  -- ファイルタイプ別フォーマッター
  formatters_by_ft = {
    -- JavaScript / TypeScript
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    
    -- Web
    html = { "prettier" },
    css = { "prettier" },
    scss = { "prettier" },
    json = { "prettier" },
    jsonc = { "prettier" },
    
    -- Markdown
    markdown = { "prettier" },
    
    -- YAML / TOML
    yaml = { "prettier" },
    toml = { "taplo" },
    
    -- Go
    go = { "gofmt", "goimports" },
    
    -- Rust
    rust = { "rustfmt" },
    
    -- Python
    python = { "black", "isort" },
    
    -- Shell
    sh = { "shfmt" },
    bash = { "shfmt" },
    
    -- SQL
    sql = { "sql_formatter" },
    
    -- Lua
    lua = { "stylua" },
    
    -- 全ファイルタイプ（末尾空白削除）
    ["*"] = { "trim_whitespace" },
  },

  -- 保存時に自動フォーマット
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
})

-- -----------------------------------------------------------------------------
-- キーマップ（coc.vim の :Format コマンド相当）
-- -----------------------------------------------------------------------------
vim.api.nvim_create_user_command("Format", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format buffer" })

-- <leader>f でフォーマット（lspconfig.lua と重複するが、conform を優先）
vim.keymap.set({ "n", "v" }, "<leader>f", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format" })
