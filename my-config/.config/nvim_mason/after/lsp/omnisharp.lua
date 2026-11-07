-- =============================================================================
-- omnisharp 個別設定（C#）
-- 前提: .NET SDK（brew install --cask dotnet-sdk）
-- =============================================================================
return {
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
}
