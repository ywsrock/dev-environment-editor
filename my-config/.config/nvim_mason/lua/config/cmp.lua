-- =============================================================================
-- cmp.lua - 補完エンジン（coc.nvim と同じ操作感）
-- =============================================================================

local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

-- friendly-snippets を読み込み
require("luasnip.loaders.from_vscode").lazy_load()

-- -----------------------------------------------------------------------------
-- nvim-cmp 設定
-- -----------------------------------------------------------------------------
cmp.setup({
  -- スニペット設定
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  -- ウィンドウ設定
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },

  -- キーマッピング（coc.nvim と同じ操作感）
  mapping = cmp.mapping.preset.insert({
    -- Tab で次の候補（coc.nvim と同じ）
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),

    -- Shift+Tab で前の候補（coc.nvim と同じ）
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),

    -- Enter で確定（coc.nvim と同じ）
    ["<CR>"] = cmp.mapping.confirm({ select = true }),

    -- Ctrl+Space で補完トリガー（coc.nvim と同じ）
    ["<C-Space>"] = cmp.mapping.complete(),

    -- スクロール
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),

    -- キャンセル
    ["<C-e>"] = cmp.mapping.abort(),
  }),

  -- 補完ソース（優先順位順）
  sources = cmp.config.sources({
    { name = "nvim_lsp" },   -- LSP
    { name = "luasnip" },    -- スニペット
    { name = "path" },       -- パス
  }, {
    { name = "buffer" },     -- バッファ
  }),

  -- フォーマット（アイコン表示）
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol_text",
      maxwidth = 50,
      ellipsis_char = "...",
      menu = {
        nvim_lsp = "[LSP]",
        luasnip = "[Snip]",
        buffer = "[Buf]",
        path = "[Path]",
      },
    }),
  },
})

-- -----------------------------------------------------------------------------
-- コマンドライン補完
-- -----------------------------------------------------------------------------
-- `/` 検索
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" }
  }
})

-- `:` コマンド
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" }
  }, {
    { name = "cmdline" }
  })
})
