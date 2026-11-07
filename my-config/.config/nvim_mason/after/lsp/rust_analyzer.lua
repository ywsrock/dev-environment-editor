-- =============================================================================
-- rust_analyzer 個別設定（自動import + inlay hints + clippy）
-- nvim-lspconfig 既定（lsp/rust_analyzer.lua）にマージされる
-- inlay hints の自動有効化は lua/config/lspconfig.lua の LspAttach で設定
-- =============================================================================
return {
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
