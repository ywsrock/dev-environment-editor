-- =============================================================================
-- editor.lua - エディタ機能プラグイン
-- =============================================================================

return {
  -- ブックマーク
  {
    "kshenoy/vim-signature",
    event = "BufReadPost",
  },

  -- 行移動
  {
    "ywsrock/vim-move",
    event = "BufReadPost",
  },

  -- ウィンドウリサイズ
  {
    "simeji/winresizer",
    cmd = "WinResizerStartResize",
    keys = {
      { "<C-e>", ":WinResizerStartResize<CR>", desc = "Window Resizer" },
    },
  },

  -- コメント
  {
    "numToStr/Comment.nvim",
    event = "BufReadPost",
    config = function()
      require("Comment").setup()
    end,
  },
}
