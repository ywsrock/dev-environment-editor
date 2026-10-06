-- =============================================================================
-- noice.lua - noice.nvim + nvim-notify 設定
-- =============================================================================

-- nvim-notify: border無効化（ambiwidth=double対応）
require("notify").setup({
  render = "wrapped-compact",
  on_open = function(win)
    vim.api.nvim_win_set_config(win, { border = "none" })
  end,
})

-- noice.nvim 設定
require("noice").setup({
  lsp = {
    -- cmp などのプラグインが Treesitter を使用するようにオーバーライド
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },

  -- プリセット設定
  presets = {
    bottom_search = true,         -- 検索時は標準のコマンドライン（<C-r><C-w>対応）
    command_palette = true,       -- コマンドラインとポップアップメニューを一緒に表示
    long_message_to_split = true, -- 長いメッセージを split で表示
    inc_rename = false,
    lsp_doc_border = false,
  },

  -- コマンドラインアイコン（Nerd Font なし用）
  cmdline = {
    format = {
      cmdline = { icon = ">" },
      search_down = { icon = "🔍⌄" },
      search_up = { icon = "🔍⌃" },
      filter = { icon = "$" },
      lua = { icon = "☾" },
      help = { icon = "?" },
    },
  },

  -- メッセージレベルアイコン
  format = {
    level = {
      icons = {
        error = "✖",
        warn = "▼",
        info = "●",
      },
    },
  },

  -- ポップアップメニュー
  popupmenu = {
    kind_icons = false,
  },

  -- inc-rename
  inc_rename = {
    cmdline = {
      format = {
        IncRename = { icon = "⟳" },
      },
    },
  },

  -- ビュー設定
  views = {
    cmdline_popup = {
      border = {
        style = "none",
        padding = { 2, 3 },
      },
      filter_options = {},
      win_options = {
        winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
      },
    },
    popup = {
      border = { style = "solid" },
    },
    hover = {
      border = { style = "solid" },
    },
    confirm = {
      border = { style = "solid" },
    },
    popupmenu = {
      border = { style = "solid" },
    },
    mini = {
      border = { style = "solid" },
    },
  },

  -- ルート設定
  routes = {
    -- "written" メッセージを非表示
    {
      filter = {
        event = "msg_show",
        kind = "",
        find = "written",
      },
      opts = { skip = true },
    },
    -- lua_ls の進捗メッセージを非表示
    {
      filter = {
        event = "lsp",
        kind = "progress",
        cond = function(message)
          local client = vim.tbl_get(message.opts, "progress", "client")
          return client == "lua_ls"
        end,
      },
      opts = { skip = true },
    },
  },
})
