-- =============================================================================
-- utils.lua - ユーティリティプラグイン
-- =============================================================================

return {
  -- 翻訳
  {
    "voldikss/vim-translator",
    keys = {
      { "<Leader>t", "<Plug>Translate", desc = "Translate" },
      { "<Leader>t", "<Plug>TranslateV", mode = "v", desc = "Translate Visual" },
      { "<Leader>w", "<Plug>TranslateW", desc = "Translate Window" },
      { "<Leader>w", "<Plug>TranslateWV", mode = "v", desc = "Translate Window Visual" },
      { "<Leader>r", "<Plug>TranslateR", desc = "Translate Replace" },
      { "<Leader>r", "<Plug>TranslateRV", mode = "v", desc = "Translate Replace Visual" },
      { "<Leader>x", "<Plug>TranslateX", desc = "Translate Clipboard" },
    },
    init = function()
      vim.g.translator_target_lang = "ja"
    end,
  },

  -- quickfix プレビュー
  {
    "ronakg/quickr-preview.vim",
    event = "QuickFixCmdPost",
    init = function()
      vim.g.quickr_preview_keymaps = 0
      vim.g.quickr_preview_position = "right"
    end,
    keys = {
      { "gs", "<plug>(quickr_preview)", desc = "Quickfix Preview" },
      { "gc", "<plug>(quickr_preview_qf_close)", desc = "Quickfix Preview Close" },
    },
  },

  -- YAML フォールド
  {
    "pedrohdz/vim-yaml-folds",
    ft = "yaml",
  },

  -- startify（セッション管理）
  {
    "mhinz/vim-startify",
    lazy = false,
    config = function()
      -- 変更されたファイルを取得
      local function git_modified()
        local files = vim.fn.systemlist("git ls-files -m 2>/dev/null")
        local result = {}
        for _, file in ipairs(files) do
          table.insert(result, { line = file, path = file })
        end
        return result
      end

      -- 未追跡ファイルを取得
      local function git_untracked()
        local files = vim.fn.systemlist("git ls-files -o --exclude-standard 2>/dev/null")
        local result = {}
        for _, file in ipairs(files) do
          table.insert(result, { line = file, path = file })
        end
        return result
      end

      -- リスト設定
      vim.g.startify_lists = {
        { type = "files", header = { "   MRU" } },
        { type = "dir", header = { "   MRU " .. vim.fn.getcwd() } },
        { type = "sessions", header = { "   Sessions" } },
        { type = "bookmarks", header = { "   Bookmarks" } },
        { type = git_modified, header = { "   git modified" } },
        { type = git_untracked, header = { "   git untracked" } },
        { type = "commands", header = { "   Commands" } },
      }

      -- NERDTree ブックマーク連携
      vim.g.startify_bookmarks = vim.fn.systemlist("cut -sd' ' -f 2- ~/.NERDTreeBookmarks")
    end,
  },
}
