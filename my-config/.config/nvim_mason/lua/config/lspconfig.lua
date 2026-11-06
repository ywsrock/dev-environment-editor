-- =============================================================================
-- lspconfig.lua - LSP 設定 + キーマップ（Neovim 0.11+ 対応）
-- =============================================================================

local capabilities = require("cmp_nvim_lsp").default_capabilities()

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

-- -----------------------------------------------------------------------------
-- キーマップ設定
-- -----------------------------------------------------------------------------
local on_attach = function(client, bufnr)
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
	"tailwindcss", -- Tailwind CSS（tailwind.config.* か package.json に tailwindcss がある時のみ）
	"emmet_language_server", -- Emmet（div.box>ul>li*3 等を展開）
	"yamlls",
	"taplo",
	"gopls",
	"bashls",
	"vimls",
	"lua_ls", -- Lua（Neovim API 対応は下部の lua_ls 追加設定）
	"dockerls",
	"lemminx",
	-- "jdtls",
	"perlnavigator",
	"powershell_es",
	"omnisharp", -- C#（要 .NET SDK、個別 settings は下部）
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
-- nvim-lspconfig 既定の rust_analyzer 設定（on_attach を引き継ぐため）
local ra_default_file = vim.api.nvim_get_runtime_file("lsp/rust_analyzer.lua", false)[1]
local ra_default = ra_default_file and dofile(ra_default_file) or {}

vim.lsp.config.rust_analyzer = {
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		-- nvim-lspconfig 既定の on_attach（:LspCargoReload コマンド作成）
		if ra_default.on_attach then
			ra_default.on_attach(client, bufnr)
		end

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
					group = "module", -- モジュール単位でグループ化
				},
				prefix = "self", -- import時のprefix（self, crate, plain）
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
			-- 診断設定（rust-analyzer 独自診断は cargo check/clippy と重複するため無効。
			-- 診断はファイルを開いた時・保存時の cargo check/clippy の結果のみ）
			diagnostics = {
				enable = false,
			},
			-- Cargo設定
			cargo = {
				features = "all", -- --all-features
				buildScripts = {
					enable = true, -- build.rs を実行
				},
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
			-- 保存時チェック（clippy）
			checkOnSave = true,
			check = {
				command = "clippy",
				features = "all", -- 省略時は cargo.features を継承
				extraArgs = { "--no-deps" },
			},
		},
	},
}

-- -----------------------------------------------------------------------------
-- lua_ls 追加設定（Neovim の設定・プラグイン開発用）
-- nvim-lspconfig 公式推奨（lsp/lua_ls.lua の説明）:
--   .luarc.json がある通常の Lua プロジェクトはそちらを優先し、
--   それ以外（Neovim 設定ディレクトリ等）では Neovim ランタイムを認識させる
-- -----------------------------------------------------------------------------
vim.lsp.config("lua_ls", {
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if
				path ~= vim.fn.stdpath("config")
				and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
			then
				return
			end
		end

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				version = "LuaJIT", -- Neovim は LuaJIT
				path = { "lua/?.lua", "lua/?/init.lua" },
			},
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME, -- vim.* API
					vim.api.nvim_get_runtime_file("lua/lspconfig", false)[1], -- LSP 設定の型
				},
			},
		})
	end,
	settings = {
		Lua = {},
	},
})

-- -----------------------------------------------------------------------------
-- omnisharp 追加設定（C#）
-- 前提: .NET SDK（brew install --cask dotnet-sdk）
-- -----------------------------------------------------------------------------
vim.lsp.config("omnisharp", {
	settings = {
		FormattingOptions = {
			EnableEditorConfigSupport = true, -- .editorconfig を尊重
			OrganizeImports = true, -- フォーマット時に using を整理
		},
		RoslynExtensionsOptions = {
			EnableAnalyzersSupport = true, -- Roslyn アナライザー診断
			EnableImportCompletion = true, -- 未 import の型も補完（自動 using）
			AnalyzeOpenDocumentsOnly = true, -- 開いているファイルのみ解析（軽量化）
			EnableDecompilationSupport = true, -- 外部ライブラリの定義へジャンプ
		},
		Sdk = {
			IncludePrereleases = true,
		},
	},
})

-- 全サーバーを有効化（rust_analyzer を追加）
local all_servers = vim.list_extend(vim.deepcopy(servers), { "rust_analyzer" })
vim.lsp.enable(all_servers)

-- -----------------------------------------------------------------------------
-- 診断表示設定
-- -----------------------------------------------------------------------------
-- 重要度別アイコン（Nerd Font）: サインとポップアップの先頭で共通利用
local diag_icons = {
	[vim.diagnostic.severity.ERROR] = "",
	[vim.diagnostic.severity.WARN] = "",
	[vim.diagnostic.severity.INFO] = "",
	[vim.diagnostic.severity.HINT] = "󰌵",
}

vim.diagnostic.config({
	-- メッセージはコード上に表示しない（波線＋サインのみ）。
	-- 見る時: ]d / [d（または ]g / [g）で移動 → ポップアップで全文表示
	--         <C-w>d → カーソル位置の診断をポップアップ表示
	--
	-- 【他の表示方法に変える場合】
	--   ・元の「行末に表示」: virtual_text = true にして、下の jump ブロックを削除
	--       行末にもアイコンを付ける場合:
	--         virtual_text = { prefix = function(d) return diag_icons[d.severity] end },
	--       行末表示をカーソル行だけにする場合: virtual_text = { current_line = true },
	--   ・「カーソル行だけ行の下に全文表示」: 次を追加し、jump ブロックを削除
	--       virtual_lines = {
	--         current_line = true,
	--         format = function(d) return diag_icons[d.severity] .. " " .. d.message end,
	--       },
	virtual_text = false,
	-- ]d / [d で診断へ移動した時、その診断をポップアップ表示（カーソルを動かすと閉じる）
	jump = {
		on_jump = function(diagnostic, bufnr)
			if diagnostic then
				vim.diagnostic.open_float({ bufnr = bufnr, scope = "cursor", focus = false })
			end
		end,
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true, -- 出力元（rustc / clippy 等）を表示
		-- 先頭に重要度アイコン（2つ目の戻り値はハイライトグループ）
		prefix = function(d)
			local hl = ({ "DiagnosticError", "DiagnosticWarn", "DiagnosticInfo", "DiagnosticHint" })[d.severity]
			return diag_icons[d.severity] .. " ", hl
		end,
	},
	-- 診断アイコン
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = diag_icons[vim.diagnostic.severity.ERROR],
			[vim.diagnostic.severity.WARN] = diag_icons[vim.diagnostic.severity.WARN],
			[vim.diagnostic.severity.HINT] = diag_icons[vim.diagnostic.severity.HINT],
			[vim.diagnostic.severity.INFO] = diag_icons[vim.diagnostic.severity.INFO],
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
-- CocList 相当のキーマップ
--   <space>o / s / a : Telescope
--   <space>ta        : location list
-- -----------------------------------------------------------------------------
if telescope_ok then
	vim.keymap.set("n", "<space>o", telescope.lsp_document_symbols, { desc = "Outline (Telescope)" })
	vim.keymap.set("n", "<space>s", telescope.lsp_workspace_symbols, { desc = "Symbols (Telescope)" })
	vim.keymap.set("n", "<space>a", function()
		telescope.diagnostics(tele_vertical({ bufnr = 0 })) -- 現在のバッファの診断
	end, { desc = "Diagnostics (Telescope)" })
end

vim.keymap.set("n", "<space>ta", function()
	vim.diagnostic.setloclist()
end, { desc = "Diagnostics (loclist)" })
