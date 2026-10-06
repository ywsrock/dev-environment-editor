-- =============================================================================
-- terminal.lua - ターミナル / フロートウィンドウ
-- =============================================================================

return {
  -- floaterm
  {
    "voldikss/vim-floaterm",
    cmd = { "FloatermNew", "FloatermToggle", "FloatermNext", "FloatermPrev" },
    keys = {
      { "<Leader>fc", ":FloatermNew<CR>", desc = "Floaterm New" },
      { "<Leader>ft", ":FloatermToggle<CR>", desc = "Floaterm Toggle" },
      { "<Leader>fn", ":FloatermNext<CR>", desc = "Floaterm Next" },
      { "<Leader>fp", ":FloatermPrev<CR>", desc = "Floaterm Prev" },
      { "<Leader>fk", ":FloatermKill<CR>", desc = "Floaterm Kill" },
    },
    init = function()
      if not vim.g.vscode then
        vim.g.floaterm_wintype = "float"
        vim.g.floaterm_position = "bottomright"
      end
    end,
  },
}
