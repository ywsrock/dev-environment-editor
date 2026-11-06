-- =============================================================================
-- lspconfig.lua - LSP 設定 + キーマップ（Neovim 0.11+ 対応）
-- =============================================================================

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- -----------------------------------------------------------------------------
-- キーマップ設定（coc.vim と同じ）
-- -----------------------------------------------------------------------------
local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  local keymap = vim.keymap.set

  -- ナビゲーション（coc.vim と同じ）
  keymap("n", "gd", vim.lsp.buf.definition, opts)           -- 定義へジャンプ
  keymap("n", "gy", vim.lsp.buf.type_definition, opts)      -- 型定義
  keymap("n", "gi", vim.lsp.buf.implementation, opts)       -- 実装へ
  keymap("n", "gr", vim.lsp.buf.references, opts)           -- 参照一覧

  -- ドキュメント（coc.vim と同じ）
  keymap("n", "K", vim.lsp.buf.hover, opts)                 -- ドキュメント表示

  -- 診断メッセージ間を移動（coc.vim: [g ]g）
  keymap("n", "[g", vim.diagnostic.goto_prev, opts)
  keymap("n", "]g", vim.diagnostic.goto_next, opts)

  -- リファクタリング（coc.vim と同じ）
  keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)       -- リネーム
  keymap("n", "<leader>ac", vim.lsp.buf.code_action, opts)  -- コードアクション
  keymap("n", "<leader>a", vim.lsp.buf.code_action, opts)   -- コードアクション（選択）
  keymap("v", "<leader>a", vim.lsp.buf.code_action, opts)

  -- フォーマット（conform.nvim で処理するが、LSP フォールバックも設定）
  keymap("n", "<leader>f", function()
    vim.lsp.buf.format({ async = true })
  end, opts)
  keymap("v", "<leader>f", function()
    vim.lsp.buf.format({ async = true })
  end, opts)

  -- Inlay Hints トグル（Neovim 0.10+）
  keymap("n", "<leader>ih", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
  end, { buffer = bufnr, desc = "Toggle Inlay Hints" })

  -- シンボルハイライト（カーソル位置）
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_autocmd("CursorHold", {
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

-- -----------------------------------------------------------------------------
-- LSP サーバー設定（Neovim 0.11+ vim.lsp.config API）
-- -----------------------------------------------------------------------------

-- 共通設定のサーバー
local servers = {
  "jsonls",
  "ts_ls",
  "pyright",
  "eslint",
  "cssls",
  "html",
  "yamlls",
  "taplo",
  "gopls",
  "bashls",
  "vimls",
  "dockerls",
  "lemminx",
  -- "jdtls",
  "perlnavigator",
  "powershell_es",
  "vuels",
}

-- Neovim 0.11+ の vim.lsp.config を使用（共通設定）
for _, server in ipairs(servers) do
  vim.lsp.config[server] = {
    capabilities = capabilities,
    on_attach = on_attach,
  }
end

-- -----------------------------------------------------------------------------
-- rust-analyzer 専用設定（自動import + inlay hints）
-- -----------------------------------------------------------------------------
vim.lsp.config.rust_analyzer = {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    -- 共通の on_attach を実行
    on_attach(client, bufnr)

    -- Inlay Hints を有効化（Neovim 0.10+）
    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
  end,
  settings = {
    ["rust-analyzer"] = {
      -- 自動import設定
      imports = {
        granularity = {
          group = "module",  -- モジュール単位でグループ化
        },
        prefix = "self",     -- import時のprefix（self, crate, plain）
      },
      -- 補完時に自動でimportを追加
      completion = {
        autoimport = {
          enable = true,
        },
        postfix = {
          enable = true,
        },
      },
      -- Inlay Hints（関数のパラメータ名・型ヒント）
      inlayHints = {
        bindingModeHints = {
          enable = true,
        },
        chainingHints = {
          enable = true,
        },
        closingBraceHints = {
          enable = true,
          minLines = 25,
        },
        closureReturnTypeHints = {
          enable = "with_block",
        },
        lifetimeElisionHints = {
          enable = "skip_trivial",
          useParameterNames = true,
        },
        maxLength = 25,
        parameterHints = {
          enable = true,
        },
        reborrowHints = {
          enable = "never",
        },
        renderColons = true,
        typeHints = {
          enable = true,
          hideClosureInitialization = false,
          hideNamedConstructor = false,
        },
      },
      -- 診断設定
      diagnostics = {
        enable = true,
        experimental = {
          enable = true,
        },
      },
      -- Cargo設定
      cargo = {
        allFeatures = true,
        loadOutDirsFromCheck = true,
        runBuildScripts = true,
      },
      -- procMacro サポート
      procMacro = {
        enable = true,
        ignored = {
          ["async-trait"] = { "async_trait" },
          ["napi-derive"] = { "napi" },
          ["async-recursion"] = { "async_recursion" },
        },
      },
      -- チェック設定（clippy を使用）
      checkOnSave = {
        allFeatures = true,
        command = "clippy",
        extraArgs = { "--no-deps" },
      },
    },
  },
}

-- 全サーバーを有効化（rust_analyzer を追加）
local all_servers = vim.tbl_extend("force", servers, { "rust_analyzer" })
vim.lsp.enable(all_servers)

-- -----------------------------------------------------------------------------
-- 診断表示設定（Neovim 0.11+ 新方式）
-- -----------------------------------------------------------------------------
vim.diagnostic.config({
  virtual_text = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
  },
  -- 診断アイコン（sign_define 非推奨のため新方式）
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = " ",
      [vim.diagnostic.severity.INFO] = " ",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
    },
  },
})

-- -----------------------------------------------------------------------------
-- CocList 相当のキーマップ（Telescope 連携）
-- -----------------------------------------------------------------------------
local telescope_ok, telescope = pcall(require, "telescope.builtin")
if telescope_ok then
  vim.keymap.set("n", "<space>a", function() vim.diagnostic.setloclist() end, { desc = "Diagnostics" })
  vim.keymap.set("n", "<space>o", telescope.lsp_document_symbols, { desc = "Outline" })
  vim.keymap.set("n", "<space>s", telescope.lsp_workspace_symbols, { desc = "Symbols" })
end
