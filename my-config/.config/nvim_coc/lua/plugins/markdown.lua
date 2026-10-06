-- =============================================================================
-- markdown.lua - Markdown プラグイン
-- =============================================================================

return {
  -- tabular（テーブル整形）
  {
    "godlygeek/tabular",
    cmd = "Tabularize",
  },

  -- vim-markdown
  {
    "preservim/vim-markdown",
    ft = "markdown",
    dependencies = { "godlygeek/tabular" },
  },

  -- markdown-preview
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = "cd app && npm install",
    cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
    keys = {
      { "<leader>gs", "<Plug>MarkdownPreview", desc = "Markdown Preview" },
      { "<leader>gc", "<Plug>MarkdownPreviewStop", desc = "Markdown Preview Stop" },
      { "<leader>gt", "<Plug>MarkdownPreviewToggle", desc = "Markdown Preview Toggle" },
    },
    init = function()
      vim.g.mkdp_command_for_global = 1
    end,
  },
}
