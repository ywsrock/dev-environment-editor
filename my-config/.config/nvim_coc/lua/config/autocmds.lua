-- =============================================================================
-- autocmds.lua - autocmd 設定
-- =============================================================================

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- -----------------------------------------------------------------------------
-- 言語別設定
-- -----------------------------------------------------------------------------
local filetype_group = augroup("filetype_settings", { clear = true })

autocmd("FileType", {
  group = filetype_group,
  pattern = "go",
  callback = function()
    vim.cmd("source ~/.config/nvim/plugins/go/format.vim")
  end,
})

autocmd("FileType", {
  group = filetype_group,
  pattern = "python",
  callback = function()
    vim.cmd("source ~/.config/nvim/plugins/python/format.vim")
  end,
})

-- -----------------------------------------------------------------------------
-- カラースキーム再読み込み時のハイライト維持
-- -----------------------------------------------------------------------------
local highlight_group = augroup("MyHighlights", { clear = true })

autocmd("ColorScheme", {
  group = highlight_group,
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "Normal", { bg = "#1e1e2e" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "#282838" })
  end,
})
