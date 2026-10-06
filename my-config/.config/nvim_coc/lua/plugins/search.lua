-- =============================================================================
-- search.lua - 検索 / ファジーファインダー
-- =============================================================================

return {
  -- fzf
  {
    "junegunn/fzf",
    build = "./install --bin",
    lazy = true,
  },

  -- fzf.vim
  {
    "junegunn/fzf.vim",
    dependencies = { "junegunn/fzf" },
    cmd = { "Files", "GFiles", "Buffers", "Rg", "Lines", "BLines", "Tags", "BTags", "Marks", "Windows", "History", "FZF" },
    keys = {
      { "<leader>fz", ":FZF .<cr>", desc = "FZF" },
    },
    config = function()
      -- アクション
      vim.g.fzf_action = {
        ["ctrl-q"] = function(lines)
          local items = {}
          for _, line in ipairs(lines) do
            table.insert(items, { filename = line, lnum = 1 })
          end
          vim.fn.setqflist(items)
          vim.cmd("copen")
          vim.cmd("cc")
        end,
        ["ctrl-t"] = "tab split",
        ["ctrl-x"] = "split",
        ["ctrl-v"] = "vsplit",
      }

      -- レイアウト
      vim.g.fzf_layout = { down = "40%" }

      -- カラー設定
      vim.g.fzf_colors = {
        fg = { "fg", "Normal" },
        bg = { "bg", "Normal" },
        query = { "fg", "Normal" },
        hl = { "fg", "Comment" },
        ["fg+"] = { "fg", "CursorLine", "CursorColumn", "Normal" },
        ["bg+"] = { "bg", "CursorLine", "CursorColumn" },
        ["hl+"] = { "fg", "Statement" },
        info = { "fg", "PreProc" },
        border = { "fg", "Ignore" },
        prompt = { "fg", "Conditional" },
        pointer = { "fg", "Exception" },
        marker = { "fg", "Keyword" },
        spinner = { "fg", "Label" },
        header = { "fg", "Comment" },
      }

      -- 履歴
      vim.g.fzf_history_dir = "~/.local/share/fzf-history"
    end,
  },

  -- plenary（telescope の依存）
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    keys = {
      {
        "<leader>ff",
        function()
          require("telescope.builtin").find_files({
            cwd = vim.g.project_root,
            find_command = { "rg", "--files", "--hidden", "--no-ignore", "--glob", "!.git/", "--glob", "!node_modules/" },
          })
        end,
        desc = "Find Files",
      },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
    },
  },
}
