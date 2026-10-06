-- =============================================================================
-- git.lua - Git プラグイン
-- =============================================================================

return {
  -- diffview（git差分表示）
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", ":DiffviewOpen<CR>", desc = "Diffview Open" },
      { "<leader>gD", ":DiffviewClose<CR>", desc = "Diffview Close" },
      { "<leader>gh", ":DiffviewFileHistory<CR>", desc = "Diffview File History" },
      { "<leader>gH", ":DiffviewFileHistory %<CR>", desc = "Diffview Current File History" },
    },
  },
}
