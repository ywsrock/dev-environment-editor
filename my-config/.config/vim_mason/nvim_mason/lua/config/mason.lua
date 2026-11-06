-- =============================================================================
-- mason.lua - LSP サーバー管理
-- =============================================================================

require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

require("mason-lspconfig").setup({
	-- 自動インストールする LSP サーバー
	ensure_installed = {
		-- 基本
		"jsonls",
		"ts_ls",
		"pyright",
		"eslint",

		-- Web
		"cssls",
		"html",

		-- 設定ファイル
		"yamlls",
		"taplo",

		-- 言語
		"gopls",
		"rust_analyzer",
		"bashls",
		"vimls",
		"dockerls",
		"lemminx",
		-- "jdtls",
		"perlnavigator",
		"powershell_es",
		"vuels",
	},

	-- 自動ハンドラー（インストール済み LSP を自動設定）
	automatic_installation = true,
})

-- formatters / lintersを自動インストール
require("mason-tool-installer").setup({
	ensure_installed = {
		"black",
		"gofumpt",
		"isort",
		"markdownlint",
		"prettier",
		"shfmt",
		"sql-formatter",
		"stylua",
	},
	auto_update = false, -- 自動更新しない（デフォルト: false）
	run_on_start = true, -- 起動時にインストール確認（デフォルト: true）
})
