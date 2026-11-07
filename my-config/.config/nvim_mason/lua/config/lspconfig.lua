-- =============================================================================
-- lspconfig.lua - LSP 共通設定 + キーマップ（Neovim 0.11+ 対応）
-- =============================================================================
-- LSP を追加する手順:
--   1. lua/config/mason.lua の ensure_installed に追加
--      （インストール済みのサーバーは mason-lspconfig が自動で起動する）
--   2. 個別設定が必要な時だけ after/lsp/<サーバー名>.lua を作成
--      （nvim-lspconfig の既定設定に自動でマージされる。例: after/lsp/rust_analyzer.lua）
-- 診断の表示設定は lua/config/diagnostic.lua
-- =============================================================================

-- 全サーバー共通（nvim-cmp の補完機能を LSP に通知）
vim.lsp.config("*", {
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

-- Telescope（未インストール時は gr / gi を標準の vim.lsp.buf.* にフォールバック）
local telescope_ok, telescope = pcall(require, "telescope.builtin")

-- Telescope の上下レイアウト（gr / gi / <space>a で共通）
-- 一覧を上・プレビューを下に表示し、長い行は折り返す
local function tele_vertical(opts)
	return vim.tbl_extend("force", {
		layout_strategy = "vertical",
		wrap_results = true, -- 長い行は切らずに折り返して全文表示
		layout_config = {
			preview_height = 0.45, -- プレビューの高さ（45%）
			mirror = true, -- 一覧を上・プレビューを下に（既定はプレビューが上）
			preview_cutoff = 1, -- 画面が低くてもプレビューを隠さない（既定は 40 行未満で非表示）
		},
	}, opts or {})
end

-- inlay hints を自動で有効にするサーバー（その他は <leader>ih で切り替え）
local inlay_hint_servers = { rust_analyzer = true }

-- -----------------------------------------------------------------------------
-- LSP 接続時のキーマップ（全サーバー共通）
-- on_attach ではなく LspAttach を使うため、nvim-lspconfig 既定の on_attach
-- （:LspCargoReload / :LspEslintFixAll 等のコマンド作成）も上書きされない
-- -----------------------------------------------------------------------------
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
	callback = function(args)
		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client then
			return
		end
		local opts = { noremap = true, silent = true, buffer = bufnr }
		local keymap = vim.keymap.set

		-- ナビゲーション
		keymap("n", "gd", vim.lsp.buf.definition, opts) -- 定義へジャンプ
		keymap("n", "gy", vim.lsp.buf.type_definition, opts) -- 型定義
		-- 実装へ（1件なら直接ジャンプ、複数なら Telescope で一覧）
		keymap("n", "gi", telescope_ok and function()
			telescope.lsp_implementations(tele_vertical())
		end or vim.lsp.buf.implementation, opts)
		-- 参照一覧（Telescope。<C-q> で quickfix に送る）
		keymap("n", "gr", telescope_ok and function()
			telescope.lsp_references(tele_vertical())
		end or vim.lsp.buf.references, opts)

		-- ドキュメント（coc.vim と同じ）
		keymap("n", "K", vim.lsp.buf.hover, opts) -- ドキュメント表示

		-- 診断メッセージ間を移動（coc.vim: [g ]g）
		-- ]d / [d（Neovim 標準）と同じ動作。移動時にポップアップ表示（jump.on_jump）
		keymap("n", "[g", function()
			vim.diagnostic.jump({ count = -1 })
		end, opts)
		keymap("n", "]g", function()
			vim.diagnostic.jump({ count = 1 })
		end, opts)

		-- リファクタリング（coc.vim と同じ）
		keymap("n", "<leader>rn", vim.lsp.buf.rename, opts) -- リネーム
		keymap("n", "<leader>ac", vim.lsp.buf.code_action, opts) -- コードアクション
		keymap("n", "<leader>a", vim.lsp.buf.code_action, opts) -- コードアクション（選択）
		keymap("v", "<leader>a", vim.lsp.buf.code_action, opts)

		-- フォーマット（,f）は conform.lua で設定（保存時と同じフォーマッター。無ければ LSP）

		-- Inlay Hints トグル（Neovim 0.10+）
		keymap("n", "<leader>ih", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
		end, { buffer = bufnr, desc = "Toggle Inlay Hints" })

		if inlay_hint_servers[client.name] and client:supports_method("textDocument/inlayHint") then
			vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
		end

		-- シンボルハイライト（カーソル位置）
		-- 1つのバッファに複数サーバーが接続しても autocmd が重複しないよう、バッファ単位の group を使う
		if client:supports_method("textDocument/documentHighlight") then
			local group = vim.api.nvim_create_augroup("UserLspHighlight" .. bufnr, { clear = true })
			vim.api.nvim_create_autocmd("CursorHold", {
				group = group,
				buffer = bufnr,
				callback = vim.lsp.buf.document_highlight,
			})
			vim.api.nvim_create_autocmd("CursorMoved", {
				group = group,
				buffer = bufnr,
				callback = vim.lsp.buf.clear_references,
			})
		end
	end,
})

-- -----------------------------------------------------------------------------
-- CocList 相当のキーマップ（Telescope）
--   <space>o / s / a（<space>ta は diagnostic.lua）
-- -----------------------------------------------------------------------------
if telescope_ok then
	vim.keymap.set("n", "<space>o", telescope.lsp_document_symbols, { desc = "Outline (Telescope)" })
	vim.keymap.set("n", "<space>s", telescope.lsp_workspace_symbols, { desc = "Symbols (Telescope)" })
	vim.keymap.set("n", "<space>a", function()
		telescope.diagnostics(tele_vertical({ bufnr = 0 })) -- 現在のバッファの診断
	end, { desc = "Diagnostics (Telescope)" })
end
