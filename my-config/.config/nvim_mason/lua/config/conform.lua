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
    -- goimports: import の追加・削除 → gofumpt: gofmt より厳格な整形
    go = { "goimports", "gofumpt" },
    
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

  -- フォーマッターの個別設定
  formatters = {
    -- SQL は T-SQL（SQL Server / SSMS）の書き方で整形（[テーブル名] / GO / TOP など）
    -- 他の DB に変える時は "tsql" を変更（postgresql / mysql / sql など。sql-formatter --help で一覧）
    sql_formatter = {
      prepend_args = { "-l", "tsql" },
    },
  },

  -- 保存時に自動フォーマット
  -- SQL は保存時に整形しない（,F で手動のみ）
  -- sql-formatter は GO の後の改行を消し「GO declare ...」と1行にするため、
  -- SSMS で実行できなくなる（GO は単独の行が必要）
  format_on_save = function(bufnr)
    if vim.bo[bufnr].filetype == "sql" then
      return
    end
    return {
      -- 複数フォーマッター（goimports → gofumpt 等）の合計時間。goimports は
      -- 不足 import の検索で初回 0.5 秒を超えることがあり、後続が打ち切られたため 2 秒に
      timeout_ms = 2000,
      lsp_fallback = true,
    }
  end,
})

-- -----------------------------------------------------------------------------
-- キーマップ（coc.vim の :Format コマンド相当）
-- -----------------------------------------------------------------------------
vim.api.nvim_create_user_command("Format", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format buffer" })

-- <leader>F でフォーマット（保存時と同じフォーマッター。無い言語は LSP で整形）
-- ※ ,f だと ,ff / ,fg 等と重なり、押してから1秒待たされるため ,F
vim.keymap.set({ "n", "v" }, "<leader>F", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format" })
