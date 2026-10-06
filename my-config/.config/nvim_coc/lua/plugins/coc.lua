-- =============================================================================
-- coc.lua - coc.nvim 設定（最重要）
-- =============================================================================

return {
  {
    "neoclide/coc.nvim",
    branch = "release",
    lazy = false,  -- 即時読み込み（LSP、補完は常に必要）
    init = function()
      -- VSCode の場合は無効化
      if vim.g.vscode then
        vim.g.coc_start_at_startup = 0
        return
      end

      -- ログレベル
      vim.g.coc_log_level = "error"

      -- 自動インストールする拡張機能
      vim.g.coc_global_extensions = {
        "coc-calc",
        "coc-cfn-lint",
        "coc-css",
        "coc-diagnostic",
        "coc-docker",
        "coc-eslint",
        "coc-fzf-preview",
        "coc-git",
        "coc-go",
        "coc-golines",
        "coc-html",
        "coc-htmlhint",
        "coc-java",
        "coc-json",
        "coc-markdownlint",
        "coc-perl",
        "coc-powershell",
        "coc-prettier",
        "coc-pyright",
        "coc-rust-analyzer",
        "coc-sh",
        "coc-snippets",
        "coc-spell-checker",
        "coc-sql",
        "coc-sqlfluff",
        "coc-toml",
        "coc-tsserver",
        "coc-vetur",
        "coc-vimlsp",
        "coc-xml",
        "coc-yaml",
      }
    end,
    config = function()
      -- VSCode の場合はスキップ
      if vim.g.vscode then
        return
      end

      local keyset = vim.keymap.set

      -- -----------------------------------------------------------------------------
      -- 補完
      -- -----------------------------------------------------------------------------
      -- Tab で補完候補を選択
      local function check_backspace()
        local col = vim.fn.col(".") - 1
        return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
      end

      keyset("i", "<TAB>", function()
        if vim.fn["coc#pum#visible"]() == 1 then
          return vim.fn["coc#pum#next"](1)
        elseif check_backspace() then
          return "<Tab>"
        else
          return vim.fn["coc#refresh"]()
        end
      end, { silent = true, noremap = true, expr = true, replace_keycodes = false })

      keyset("i", "<S-TAB>", function()
        if vim.fn["coc#pum#visible"]() == 1 then
          return vim.fn["coc#pum#prev"](1)
        else
          return "<C-h>"
        end
      end, { silent = true, noremap = true, expr = true, replace_keycodes = false })

      -- Enter で補完確定
      keyset("i", "<CR>", function()
        if vim.fn["coc#pum#visible"]() == 1 then
          return vim.fn["coc#pum#confirm"]()
        else
          return "<C-g>u<CR><c-r>=coc#on_enter()<CR>"
        end
      end, { silent = true, noremap = true, expr = true, replace_keycodes = false })

      -- Ctrl+Space で補完をトリガー
      keyset("i", "<c-space>", "coc#refresh()", { silent = true, expr = true })

      -- -----------------------------------------------------------------------------
      -- ナビゲーション
      -- -----------------------------------------------------------------------------
      -- 診断メッセージ間を移動
      keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", { silent = true })
      keyset("n", "]g", "<Plug>(coc-diagnostic-next)", { silent = true })

      -- コードナビゲーション
      keyset("n", "gd", "<Plug>(coc-definition)", { silent = true })
      keyset("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
      keyset("n", "gi", "<Plug>(coc-implementation)", { silent = true })
      keyset("n", "gr", "<Plug>(coc-references)", { silent = true })

      -- -----------------------------------------------------------------------------
      -- ドキュメント
      -- -----------------------------------------------------------------------------
      -- K でドキュメント表示
      local function show_documentation()
        if vim.fn.CocAction("hasProvider", "hover") then
          vim.fn.CocActionAsync("doHover")
        else
          vim.fn.feedkeys("K", "in")
        end
      end

      keyset("n", "K", show_documentation, { silent = true })

      -- カーソル位置のシンボルをハイライト
      vim.api.nvim_create_autocmd("CursorHold", {
        callback = function()
          vim.fn.CocActionAsync("highlight")
        end,
      })

      -- -----------------------------------------------------------------------------
      -- リファクタリング
      -- -----------------------------------------------------------------------------
      -- シンボル名変更
      keyset("n", "<leader>rn", "<Plug>(coc-rename)", { silent = true })

      -- コードフォーマット
      keyset("x", "<leader>f", "<Plug>(coc-format-selected)", { silent = true })
      keyset("n", "<leader>f", "<Plug>(coc-format-selected)", { silent = true })

      -- コードアクション
      keyset("x", "<leader>a", "<Plug>(coc-codeaction-selected)", { silent = true })
      keyset("n", "<leader>a", "<Plug>(coc-codeaction-selected)", { silent = true })
      keyset("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", { silent = true })
      keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)", { silent = true })
      keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", { silent = true })

      -- リファクタリング
      keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
      keyset("x", "<leader>ra", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
      keyset("n", "<leader>ra", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

      -- Code Lens
      keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", { silent = true })

      -- -----------------------------------------------------------------------------
      -- テキストオブジェクト
      -- -----------------------------------------------------------------------------
      keyset("x", "if", "<Plug>(coc-funcobj-i)", { silent = true })
      keyset("o", "if", "<Plug>(coc-funcobj-i)", { silent = true })
      keyset("x", "af", "<Plug>(coc-funcobj-a)", { silent = true })
      keyset("o", "af", "<Plug>(coc-funcobj-a)", { silent = true })
      keyset("x", "ic", "<Plug>(coc-classobj-i)", { silent = true })
      keyset("o", "ic", "<Plug>(coc-classobj-i)", { silent = true })
      keyset("x", "ac", "<Plug>(coc-classobj-a)", { silent = true })
      keyset("o", "ac", "<Plug>(coc-classobj-a)", { silent = true })

      -- -----------------------------------------------------------------------------
      -- スクロール
      -- -----------------------------------------------------------------------------
      keyset("n", "<C-f>", function()
        if vim.fn["coc#float#has_scroll"]() == 1 then
          return vim.fn["coc#float#scroll"](1)
        else
          return "<C-f>"
        end
      end, { silent = true, nowait = true, expr = true })

      keyset("n", "<C-b>", function()
        if vim.fn["coc#float#has_scroll"]() == 1 then
          return vim.fn["coc#float#scroll"](0)
        else
          return "<C-b>"
        end
      end, { silent = true, nowait = true, expr = true })

      keyset("i", "<C-f>", function()
        if vim.fn["coc#float#has_scroll"]() == 1 then
          return "<c-r>=coc#float#scroll(1)<cr>"
        else
          return "<Right>"
        end
      end, { silent = true, nowait = true, expr = true })

      keyset("i", "<C-b>", function()
        if vim.fn["coc#float#has_scroll"]() == 1 then
          return "<c-r>=coc#float#scroll(0)<cr>"
        else
          return "<Left>"
        end
      end, { silent = true, nowait = true, expr = true })

      keyset("v", "<C-f>", function()
        if vim.fn["coc#float#has_scroll"]() == 1 then
          return vim.fn["coc#float#scroll"](1)
        else
          return "<C-f>"
        end
      end, { silent = true, nowait = true, expr = true })

      keyset("v", "<C-b>", function()
        if vim.fn["coc#float#has_scroll"]() == 1 then
          return vim.fn["coc#float#scroll"](0)
        else
          return "<C-b>"
        end
      end, { silent = true, nowait = true, expr = true })

      -- 選択範囲
      keyset("n", "<C-s>", "<Plug>(coc-range-select)", { silent = true })
      keyset("x", "<C-s>", "<Plug>(coc-range-select)", { silent = true })

      -- -----------------------------------------------------------------------------
      -- コマンド
      -- -----------------------------------------------------------------------------
      vim.api.nvim_create_user_command("Format", function()
        vim.fn.CocActionAsync("format")
      end, {})

      vim.api.nvim_create_user_command("Fold", function(opts)
        vim.fn.CocAction("fold", opts.args)
      end, { nargs = "?" })

      vim.api.nvim_create_user_command("OR", function()
        vim.fn.CocActionAsync("runCommand", "editor.action.organizeImport")
      end, {})

      vim.api.nvim_create_user_command("Prettier", function()
        vim.cmd("CocCommand prettier.forceFormatDocument")
      end, {})

      -- -----------------------------------------------------------------------------
      -- CocList マッピング
      -- -----------------------------------------------------------------------------
      keyset("n", "<space>a", ":<C-u>CocList diagnostics<cr>", { silent = true, nowait = true })
      keyset("n", "<space>e", ":<C-u>CocList extensions<cr>", { silent = true, nowait = true })
      keyset("n", "<space>c", ":<C-u>CocList commands<cr>", { silent = true, nowait = true })
      keyset("n", "<space>o", ":<C-u>CocList outline<cr>", { silent = true, nowait = true })
      keyset("n", "<space>s", ":<C-u>CocList -I symbols<cr>", { silent = true, nowait = true })
      keyset("n", "<space>j", ":<C-u>CocNext<CR>", { silent = true, nowait = true })
      keyset("n", "<space>k", ":<C-u>CocPrev<CR>", { silent = true, nowait = true })
      keyset("n", "<space>p", ":<C-u>CocListResume<CR>", { silent = true, nowait = true })

      -- -----------------------------------------------------------------------------
      -- ステータスライン
      -- -----------------------------------------------------------------------------
      vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

      -- -----------------------------------------------------------------------------
      -- autocmd
      -- -----------------------------------------------------------------------------
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "typescript", "json" },
        callback = function()
          vim.opt_local.formatexpr = "CocAction('formatSelected')"
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "CocJumpPlaceholder",
        callback = function()
          vim.fn.CocActionAsync("showSignatureHelp")
        end,
      })
    end,
  },
}
