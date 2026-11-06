-- =============================================================================
-- fzf_lua.lua - fzf-lua 設定（LSP の結果を fzf で表示）
-- =============================================================================
-- キーマップは lspconfig.lua 側で設定（gr / gi / <space>o / <space>s / <space>a）
--
-- fzf 画面内の主な操作:
--   <CR>    ジャンプ
--   ctrl-v / ctrl-s / ctrl-t   縦分割 / 横分割 / タブで開く
--   alt-q   選択した結果を quickfix に送る
--   ※ 結果が1件だけの場合は直接ジャンプ（jump1 = true、既定）
-- =============================================================================

local ok, fzf = pcall(require, "fzf-lua")
if not ok then
	vim.notify("fzf-lua not installed. Run :PluginInstall", vim.log.levels.WARN)
	return
end

-- 既定プロファイルは { "border-fused", "hide" }。border-fused は罫線の結合文字（┬ ┴ 等）を
-- 使うが、ambiwidth=double（options.vim）では使えず毎回警告が出るため外す
fzf.setup({ "hide" })

-- vim.ui.select（コードアクション等の選択画面）も fzf で表示
fzf.register_ui_select()
