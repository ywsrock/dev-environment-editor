-- =============================================================================
-- colorscheme.lua - カラースキーム
-- =============================================================================

return {
  -- メインカラースキーム: tokyonight
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("tokyonight")

      -- アクティブウィンドウの背景色
      vim.api.nvim_set_hl(0, "Normal", { bg = "#1e1e2e" })
      -- 非アクティブウィンドウの背景色
      vim.api.nvim_set_hl(0, "NormalNC", { bg = "#282838" })
      -- その他のハイライト
      vim.api.nvim_set_hl(0, "NonText", { bg = "NONE", fg = "NONE" })
      vim.api.nvim_set_hl(0, "SpecialKey", { bg = "NONE", fg = "NONE" })
      vim.api.nvim_set_hl(0, "CursorLine", { underline = true })
    end,
  },

  -- フォールバックカラースキーム
  { "joshdick/onedark.vim", lazy = true },
  { "EdenEast/nightfox.nvim", lazy = true },
  { "arcticicestudio/nord-vim", lazy = true },
}
