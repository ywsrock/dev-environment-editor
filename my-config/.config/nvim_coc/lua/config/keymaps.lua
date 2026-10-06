-- =============================================================================
-- keymaps.lua - キーマッピング
-- =============================================================================

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- -----------------------------------------------------------------------------
-- 検索ハイライト解除
-- -----------------------------------------------------------------------------
map("n", "<ESC><ESC>", ":nohlsearch<CR>", opts)

-- -----------------------------------------------------------------------------
-- NERDTree（プラグイン側で keys 設定するが、基本マッピングはここに）
-- -----------------------------------------------------------------------------
-- ※ NERDTree のキーマッピングは lua/plugins/ui.lua で定義

-- -----------------------------------------------------------------------------
-- Telescope / fzf（プラグイン側で keys 設定）
-- -----------------------------------------------------------------------------
-- ※ Telescope のキーマッピングは lua/plugins/search.lua で定義

-- -----------------------------------------------------------------------------
-- 翻訳（vim-translator）
-- -----------------------------------------------------------------------------
vim.g.translator_target_lang = "ja"
map("n", "<Leader>t", "<Plug>Translate", { silent = true })
map("v", "<Leader>t", "<Plug>TranslateV", { silent = true })
map("n", "<Leader>w", "<Plug>TranslateW", { silent = true })
map("v", "<Leader>w", "<Plug>TranslateWV", { silent = true })
map("n", "<Leader>r", "<Plug>TranslateR", { silent = true })
map("v", "<Leader>r", "<Plug>TranslateRV", { silent = true })
map("n", "<Leader>x", "<Plug>TranslateX", { silent = true })

-- 翻訳ウィンドウスクロール
map("n", "<M-f>", function()
  if vim.fn["translator#window#float#has_scroll"]() == 1 then
    return vim.fn["translator#window#float#scroll"](1)
  else
    return "<M-f>"
  end
end, { expr = true, silent = true })

map("n", "<M-b>", function()
  if vim.fn["translator#window#float#has_scroll"]() == 1 then
    return vim.fn["translator#window#float#scroll"](0)
  else
    return "<M-b>"
  end
end, { expr = true, silent = true })

-- -----------------------------------------------------------------------------
-- Diffview (Git)
-- -----------------------------------------------------------------------------
map("n", "<leader>gd", ":DiffviewOpen<CR>", opts)
map("n", "<leader>gD", ":DiffviewClose<CR>", opts)
map("n", "<leader>gh", ":DiffviewFileHistory<CR>", opts)
map("n", "<leader>gH", ":DiffviewFileHistory %<CR>", opts)

-- -----------------------------------------------------------------------------
-- Noice 通知履歴
-- -----------------------------------------------------------------------------
map("n", "<leader>nh", function()
  require("telescope").extensions.notify.notify()
end, opts)

-- -----------------------------------------------------------------------------
-- quickfix プレビュー
-- -----------------------------------------------------------------------------
vim.g.quickr_preview_keymaps = 0
vim.g.quickr_preview_position = "right"
map("n", "gs", "<plug>(quickr_preview)", {})
map("n", "gc", "<plug>(quickr_preview_qf_close)", {})

-- -----------------------------------------------------------------------------
-- Markdown プレビュー
-- -----------------------------------------------------------------------------
vim.g.mkdp_command_for_global = 1
map("n", "<leader>gs", "<Plug>MarkdownPreview", {})
map("n", "<leader>gc", "<Plug>MarkdownPreviewStop", {})
map("n", "<leader>gt", "<Plug>MarkdownPreviewToggle", {})

-- -----------------------------------------------------------------------------
-- Floaterm（VSCode以外）
-- -----------------------------------------------------------------------------
if not vim.g.vscode then
  vim.g.floaterm_keymap_new = "<Leader>fc"
  vim.g.floaterm_keymap_prev = "<Leader>fp"
  vim.g.floaterm_keymap_next = "<Leader>fn"
  vim.g.floaterm_keymap_first = "<Leader>f^"
  vim.g.floaterm_keymap_last = "<Leader>f$"
  vim.g.floaterm_keymap_hide = "<Leader>fh"
  vim.g.floaterm_keymap_show = "<Leader>fs"
  vim.g.floaterm_keymap_kill = "<Leader>fk"
  vim.g.floaterm_keymap_toggle = "<Leader>ft"
  vim.g.floaterm_wintype = "float"
  vim.g.floaterm_position = "bottomright"
end

-- -----------------------------------------------------------------------------
-- Copilot（VSCode以外）
-- -----------------------------------------------------------------------------
if not vim.g.vscode then
  vim.g.copilot_filetypes = { ["*"] = true }
  map("n", "<leader>cp", ":Copilot panel<CR>", opts)
  map("i", "<C-j>", "<Plug>(copilot-next)", {})
  map("i", "<C-k>", "<Plug>(copilot-previous)", {})
  map("i", "<C-l>", "<Plug>(copilot-accept-word)", {})
end
