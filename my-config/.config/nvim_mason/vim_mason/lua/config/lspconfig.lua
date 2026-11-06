-- =============================================================================
-- lspconfig.lua - LSP 設定 + キーマップ（Neovim 0.11+ 対応）
-- =============================================================================

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- fzf-lua（未インストール時は標準の vim.lsp.buf.* にフォールバック）
local fzf_ok, fzf = pcall(require, "fzf-lua")

-- -----------------------------------------------------------------------------
-- キーマップ設定（coc.vim と同じ）
-- -----------------------------------------------------------------------------
local on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }
	local keymap = vim.keymap.set

	-- ナビゲーション（coc.vim と同じ）
	keymap("n", "gd", vim.lsp.buf.definition, opts) -- 定義へジャンプ
	keymap("n", "gy", vim.lsp.buf.type_definition, opts) -- 型定義
	keymap("n", "gi", fzf_ok and fzf.lsp_implementations or vim.lsp.buf.implementation, opts) -- 実装へ（fzf）
	keymap("n", "gr", fzf_ok and fzf.lsp_references or vim.lsp.buf.references, opts) -- 参照一覧（fzf）

	-- ドキュメント（coc.vim と同じ）
	keymap("n", "K", vim.lsp.buf.hover, opts) -- ドキュメント表示

	-- 診断メッセージ間を移動（coc.vim: [g ]g）
	keymap("n", "[g", vim.diagnostic.goto_prev, opts)
	keymap("n", "]g", vim.diagnostic.goto_next, opts)

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
	"vue_ls", -- Vue 3（ts_ls と連携。下部の ts_ls 追加設定を参照）
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
-- 【重複診断の対策】
-- rust-analyzer は同じエラーを2つの経路で送ってくる:
--   - 独自診断（source="rust-analyzer"）: pull（textDocument/diagnostic）→ 編集中も即時
--   - cargo check/clippy（source="rustc"）: push（publishDiagnostics）→ 開いた時・保存時
-- 別 namespace のため、どちらかが届くたびに突き合わせ、
-- 同じ行・同じコードの rustc 診断がある rust-analyzer 診断だけを除外する。
-- （rustc 診断がまだ無い保存前の新しいエラーは、独自診断がそのまま表示される）
local function prune_duplicate_rust_diagnostics(bufnr)
	if not (bufnr and vim.api.nvim_buf_is_loaded(bufnr)) then
		return
	end
	local all = vim.diagnostic.get(bufnr)
	local rustc = {}
	for _, d in ipairs(all) do
		if d.source == "rustc" and d.code then
			rustc[d.lnum .. ":" .. tostring(d.code)] = true
		end
	end
	if next(rustc) == nil then
		return
	end
	local by_ns, changed = {}, {}
	for _, d in ipairs(all) do
		by_ns[d.namespace] = by_ns[d.namespace] or {}
		if d.source == "rust-analyzer" and d.code and rustc[d.lnum .. ":" .. tostring(d.code)] then
			changed[d.namespace] = true
		else
			table.insert(by_ns[d.namespace], d)
		end
	end
	for ns in pairs(changed) do
		vim.diagnostic.set(ns, bufnr, by_ns[ns])
	end
end

-- nvim-lspconfig 既定の rust_analyzer 設定（on_attach を引き継ぐため）
local ra_default_file = vim.api.nvim_get_runtime_file("lsp/rust_analyzer.lua", false)[1]
local ra_default = ra_default_file and dofile(ra_default_file) or {}

vim.lsp.config.rust_analyzer = {
	capabilities = capabilities,
	handlers = {
		-- push（rustc）
		["textDocument/publishDiagnostics"] = function(err, result, ctx)
			vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx)
			if result and result.uri then
				prune_duplicate_rust_diagnostics(vim.uri_to_bufnr(result.uri))
			end
		end,
		-- pull（rust-analyzer 独自）
		["textDocument/diagnostic"] = function(err, result, ctx)
			vim.lsp.diagnostic.on_diagnostic(err, result, ctx)
			prune_duplicate_rust_diagnostics(ctx.bufnr)
		end,
	},
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
			-- 診断設定
			diagnostics = {
				enable = true,
				-- rustc との重複は上の dedup_rust_diagnostics で除外
				experimental = {
					enable = true,
				},
			},
			-- Cargo設定
			cargo = {
				features = "all", -- --all-features（旧 cargo.allFeatures）
				buildScripts = {
					enable = true, -- build.rs を実行（旧 runBuildScripts / loadOutDirsFromCheck）
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
			-- 保存時チェック（checkOnSave は boolean のみ。詳細は check.* に移動）
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
-- ts_ls 追加設定（Vue 連携）
-- vue_ls は hybrid mode で HTML/CSS 部分のみ担当し、<script> の TypeScript は
-- ts_ls + @vue/typescript-plugin が処理する。vue_ls 側の設定は不要（lspconfig 既定）。
-- 参照: https://github.com/vuejs/language-tools/wiki/Neovim
-- -----------------------------------------------------------------------------
local vue_language_server_path = vim.fn.stdpath("data")
	.. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

vim.lsp.config("ts_ls", {
	init_options = {
		plugins = {
			{
				name = "@vue/typescript-plugin",
				location = vue_language_server_path,
				languages = { "vue" },
				configNamespace = "typescript",
			},
		},
	},
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
})

-- -----------------------------------------------------------------------------
-- omnisharp 追加設定（C#）
-- capabilities / on_attach は上の共通ループで設定済み。
-- 関数呼び出し形式 vim.lsp.config(name, cfg) は既存設定にマージされる
-- （vim.lsp.config.name = cfg の代入形式だと上書きになるので注意）
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
-- CocList 相当のキーマップ
--   <space>o / s / a    : Telescope（優先）
--   <space>fo / fs / fa : fzf-lua（f = fzf）
--   <space>ta           : location list
-- -----------------------------------------------------------------------------
local telescope_ok, telescope = pcall(require, "telescope.builtin")
if telescope_ok then
	vim.keymap.set("n", "<space>o", telescope.lsp_document_symbols, { desc = "Outline (Telescope)" })
	vim.keymap.set("n", "<space>s", telescope.lsp_workspace_symbols, { desc = "Symbols (Telescope)" })
	vim.keymap.set("n", "<space>a", function()
		telescope.diagnostics({ bufnr = 0 }) -- 現在のバッファの診断
	end, { desc = "Diagnostics (Telescope)" })
end

if fzf_ok then
	vim.keymap.set("n", "<space>fo", fzf.lsp_document_symbols, { desc = "Outline (fzf)" })
	-- 入力のたびに LSP へ再問い合わせ（空クエリで結果を返さないサーバーでも検索可能）
	vim.keymap.set("n", "<space>fs", fzf.lsp_live_workspace_symbols, { desc = "Symbols (fzf)" })
	vim.keymap.set("n", "<space>fa", fzf.diagnostics_document, { desc = "Diagnostics (fzf)" })
end

vim.keymap.set("n", "<space>ta", function()
	vim.diagnostic.setloclist()
end, { desc = "Diagnostics (loclist)" })
