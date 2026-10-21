-- =============================================================================
-- treesitter.lua - nvim-treesitter 設定
-- =============================================================================

-- プラグイン未インストール時はスキップ
local ok, configs = pcall(require, 'nvim-treesitter.configs')
if not ok then
  vim.notify('nvim-treesitter not installed. Run :PluginInstall', vim.log.levels.WARN)
  return
end

--
-- ショートカットキー:
--   [インクリメンタル選択]
--     <CR>      選択開始 / ノード単位で拡大
--     <S-CR>    スコープ単位で拡大
--     <BS>      選択範囲を縮小
--
--   [テキストオブジェクト]（Visual/Operator モード）
--     af / if   関数の外側 / 内側を選択
--     ac / ic   クラスの外側 / 内側を選択
--     aa / ia   引数の外側 / 内側を選択
--     例: vaf → 関数全体を選択、dif → 関数内部を削除
--
--   [移動]
--     ]m / [m   次 / 前の関数開始位置へ
--     ]M / [M   次 / 前の関数終了位置へ
--     ]] / [[   次 / 前のクラス開始位置へ
--     ][ / []   次 / 前のクラス終了位置へ
--
--   [その他]
--     <Leader>tc  Treesitter Context のトグル（現在のコンテキスト表示）
--
-- コマンド:
--   :TSInstallInfo        インストール済みパーサー一覧
--   :TSInstall <lang>     指定言語のパーサーをインストール
--   :TSUpdate             全パーサーを更新
--   :TSModuleInfo         有効なモジュール一覧
--
-- =============================================================================

configs.setup({
  -- ---------------------------------------------------------------------------
  -- 自動インストールする言語パーサー
  -- ---------------------------------------------------------------------------
  ensure_installed = {
    -- Neovim 必須
    'lua', 'vim', 'vimdoc', 'query',
    -- Web 開発
    'javascript', 'typescript', 'tsx', 'html', 'css', 'scss',
    -- バックエンド
    'python', 'go', 'rust',
    -- 設定ファイル
    'json', 'yaml', 'toml', 'xml',
    -- シェル
    'bash',
    -- ドキュメント
    'markdown', 'markdown_inline',
    -- データベース
    'sql',
    -- その他
    'dockerfile', 'gitignore', 'gitcommit', 'diff',
    'regex', 'comment',
  },

  -- パーサーの自動インストール（ファイルを開いた時）
  auto_install = true,

  -- ---------------------------------------------------------------------------
  -- シンタックスハイライト
  -- ---------------------------------------------------------------------------
  highlight = {
    enable = true,
    -- Vim の正規表現ハイライトを無効化（treesitter に任せる）
    additional_vim_regex_highlighting = false,
    -- 大きいファイルでは無効化（パフォーマンス対策）
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
  },

  -- ---------------------------------------------------------------------------
  -- インデント（= で整形時に使用）
  -- ---------------------------------------------------------------------------
  indent = {
    enable = true,
  },

  -- ---------------------------------------------------------------------------
  -- インクリメンタル選択
  -- ---------------------------------------------------------------------------
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection    = '<CR>',     -- 選択開始（ノーマルモードから）
      node_incremental  = '<CR>',     -- ノード単位で選択範囲を拡大
      scope_incremental = '<S-CR>',   -- スコープ単位で選択範囲を拡大
      node_decremental  = '<BS>',     -- 選択範囲を縮小
    },
  },

  -- ---------------------------------------------------------------------------
  -- テキストオブジェクト（nvim-treesitter-textobjects）
  -- ---------------------------------------------------------------------------
  textobjects = {
    -- 選択
    select = {
      enable = true,
      -- カーソル位置から先読みして最も近いオブジェクトを選択
      lookahead = true,
      keymaps = {
        -- 関数
        ['af'] = { query = '@function.outer', desc = '関数の外側を選択' },
        ['if'] = { query = '@function.inner', desc = '関数の内側を選択' },
        -- クラス
        ['ac'] = { query = '@class.outer', desc = 'クラスの外側を選択' },
        ['ic'] = { query = '@class.inner', desc = 'クラスの内側を選択' },
        -- 引数/パラメータ
        ['aa'] = { query = '@parameter.outer', desc = '引数の外側を選択' },
        ['ia'] = { query = '@parameter.inner', desc = '引数の内側を選択' },
        -- 条件文
        ['ai'] = { query = '@conditional.outer', desc = '条件文の外側を選択' },
        ['ii'] = { query = '@conditional.inner', desc = '条件文の内側を選択' },
        -- ループ
        ['al'] = { query = '@loop.outer', desc = 'ループの外側を選択' },
        ['il'] = { query = '@loop.inner', desc = 'ループの内側を選択' },
        -- コメント
        ['a/'] = { query = '@comment.outer', desc = 'コメントを選択' },
      },
    },

    -- 移動
    move = {
      enable = true,
      set_jumps = true, -- ジャンプリストに追加
      goto_next_start = {
        [']m'] = { query = '@function.outer', desc = '次の関数開始位置へ' },
        [']]'] = { query = '@class.outer', desc = '次のクラス開始位置へ' },
        [']a'] = { query = '@parameter.inner', desc = '次の引数へ' },
      },
      goto_next_end = {
        [']M'] = { query = '@function.outer', desc = '次の関数終了位置へ' },
        [']['] = { query = '@class.outer', desc = '次のクラス終了位置へ' },
      },
      goto_previous_start = {
        ['[m'] = { query = '@function.outer', desc = '前の関数開始位置へ' },
        ['[['] = { query = '@class.outer', desc = '前のクラス開始位置へ' },
        ['[a'] = { query = '@parameter.inner', desc = '前の引数へ' },
      },
      goto_previous_end = {
        ['[M'] = { query = '@function.outer', desc = '前の関数終了位置へ' },
        ['[]'] = { query = '@class.outer', desc = '前のクラス終了位置へ' },
      },
    },

    -- スワップ（引数の入れ替えなど）
    swap = {
      enable = true,
      swap_next = {
        ['<Leader>sn'] = { query = '@parameter.inner', desc = '次の引数と入れ替え' },
      },
      swap_previous = {
        ['<Leader>sp'] = { query = '@parameter.inner', desc = '前の引数と入れ替え' },
      },
    },
  },
})

-- =============================================================================
-- nvim-treesitter-context 設定（現在のコンテキスト表示）
-- =============================================================================
local context_ok, treesitter_context = pcall(require, 'treesitter-context')
if context_ok then
  treesitter_context.setup({
    enable = true,          -- デフォルトで有効
    max_lines = 3,          -- 表示する最大行数
    min_window_height = 0,  -- 最小ウィンドウ高さ（0 = 制限なし）
    line_numbers = true,    -- 行番号を表示
    multiline_threshold = 20, -- 複数行のコンテキストの最大行数
    trim_scope = 'outer',   -- 外側からトリミング
    mode = 'cursor',        -- 'cursor' or 'topline'
    separator = nil,        -- セパレータ文字（nil = 非表示）
    zindex = 20,            -- フローティングウィンドウの z-index
  })

  -- Treesitter Context トグル
  vim.keymap.set('n', '<Leader>tc', function()
    treesitter_context.toggle()
  end, { desc = 'Treesitter Context のトグル' })
end

-- =============================================================================
-- rainbow-delimiters 設定（虹色括弧）
-- =============================================================================
local rainbow_ok, rainbow_delimiters = pcall(require, 'rainbow-delimiters')
if rainbow_ok then
  vim.g.rainbow_delimiters = {
    strategy = {
      [''] = rainbow_delimiters.strategy['global'],
      vim = rainbow_delimiters.strategy['local'],
    },
    query = {
      [''] = 'rainbow-delimiters',
      lua = 'rainbow-blocks',
    },
    priority = {
      [''] = 110,
      lua = 210,
    },
    highlight = {
      'RainbowDelimiterRed',
      'RainbowDelimiterYellow',
      'RainbowDelimiterBlue',
      'RainbowDelimiterOrange',
      'RainbowDelimiterGreen',
      'RainbowDelimiterViolet',
      'RainbowDelimiterCyan',
    },
  }
end

-- =============================================================================
-- 繰り返し移動用ヘルパー（; と , で繰り返し）
-- =============================================================================
local repeat_ok, ts_repeat_move = pcall(require, 'nvim-treesitter.textobjects.repeatable_move')
if repeat_ok then
  -- ; で次へ、, で前へ（Vim 標準の f/t 移動と統一）
  vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move_next,
    { desc = '次の treesitter 移動を繰り返し' })
  vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_previous,
    { desc = '前の treesitter 移動を繰り返し' })

  -- f/F/t/T も統合（オプション：標準の動作を維持したい場合はコメントアウト）
  vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f_expr, { expr = true })
  vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F_expr, { expr = true })
  vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t_expr, { expr = true })
  vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T_expr, { expr = true })
end
