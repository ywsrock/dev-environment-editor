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
	-- 自動インストールする LSP サーバー（LSP を追加する時はここに追加）
	-- 個別設定が必要なサーバーは after/lsp/<サーバー名>.lua（rust_analyzer / lua_ls / omnisharp）
	ensure_installed = {
		-- 基本
		"jsonls",
		"ts_ls",
		"pyright",
		"eslint",

		-- Web
		"cssls",
		"html",
		"tailwindcss", -- Tailwind CSS（Tailwind 使用プロジェクトでのみ起動）
		"emmet_language_server", -- Emmet（HTML / JSX / TSX / CSS）

		-- 設定ファイル
		"yamlls",
		"taplo",

		-- 言語
		"gopls",
		"rust_analyzer",
		"bashls",
		"vimls",
		"lua_ls",
		"dockerls",
		"lemminx",
		-- "jdtls",
		"perlnavigator",
		"powershell_es",
		"omnisharp", -- C#（要 .NET SDK）
	},

	-- mason-lspconfig v2: インストール済みパッケージを LSP として自動起動する
	-- （vim.lsp.enable を自動で実行。lspconfig.lua 側でのサーバー一覧は不要）。
	-- stylua はフォーマッター（conform 用）として導入しているため除外
	-- （stylua 2.0.2 は --lsp 非対応で、LSP として起動すると exit code 2 で終了する）
	automatic_enable = {
		exclude = { "stylua" },
	},
})

-- formatters / lintersを自動インストール
require("mason-tool-installer").setup({
	ensure_installed = {
		"black",
		"gofumpt",
		"goimports",
		"isort",
		"prettier",
		"shfmt",
		"sql-formatter",
		"stylua",
		"tree-sitter-cli", -- Treesitter パーサーのビルドに必要（nvim-treesitter main ブランチ）
	},
	auto_update = false, -- 自動更新しない（デフォルト: false）
	run_on_start = true, -- 起動時にインストール確認（デフォルト: true）
})
