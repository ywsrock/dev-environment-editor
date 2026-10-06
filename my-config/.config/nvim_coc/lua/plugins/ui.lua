-- =============================================================================
-- ui.lua - UI / 表示プラグイン
-- =============================================================================

return {
  -- ステータスバー
  {
    "itchyny/lightline.vim",
    lazy = false,
    init = function()
      vim.g.lightline = { colorscheme = "tokyonight" }
    end,
  },

  -- ファイルエクスプローラー
  {
    "preservim/nerdtree",
    keys = {
      { "<leader>n", ":NERDTreeFocus<CR>", desc = "NERDTree Focus" },
      { "<C-n>", ":NERDTree<CR>", desc = "NERDTree Open" },
      { "<C-t>", ":NERDTreeToggle<CR>", desc = "NERDTree Toggle" },
      { "<C-f>", ":NERDTreeFind<CR>", desc = "NERDTree Find" },
    },
    cmd = { "NERDTree", "NERDTreeToggle", "NERDTreeFind", "NERDTreeFocus" },
  },

  -- ファイルアイコン
  {
    "nvim-tree/nvim-web-devicons",
    lazy = false,
  },

  -- インデントガイド
  {
    "nathanaelkane/vim-indent-guides",
    event = "BufReadPost",
    init = function()
      if not vim.g.vscode then
        vim.g.indent_guides_enable_on_vim_startup = 1
      end
    end,
  },

  -- 全角スペース表示
  {
    "enbunsui/vim-zenspace",
    event = "BufReadPost",
  },

  -- アニメーションカーソル
  {
    "sphamba/smear-cursor.nvim",
    event = "BufReadPost",
    config = function()
      require("smear_cursor").enabled = true
    end,
  },
}
