-- =============================================================================
-- telescope.lua - Telescope 設定
-- =============================================================================

local M = {}

-- Ctrl-y で絶対パスをクリップボードにコピー
local function copy_path_action()
  local state = require('telescope.actions.state')
  local entry = state.get_selected_entry()
  local path = entry.path or vim.fn.fnamemodify(entry.value, ':p')
  vim.fn.setreg('+', path)
  print('Copied: ' .. path)
end

-- find_files のオプション
M.find_files = function()
  require('telescope.builtin').find_files({
    cwd = vim.g.project_root,
    find_command = {
      "rg", "--files", "--hidden", "--no-ignore",
      "--glob", "!.git/",
      "--glob", "!node_modules/",
    },
    attach_mappings = function(_, map)
      map('i', '<C-y>', copy_path_action)
      return true
    end,
  })
end

return M
