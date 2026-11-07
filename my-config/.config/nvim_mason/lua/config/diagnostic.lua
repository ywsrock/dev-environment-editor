-- =============================================================================
-- diagnostic.lua - 診断の表示設定 + 診断一覧キーマップ
-- =============================================================================

-- 重要度別アイコン（Nerd Font）: サインとポップアップの先頭で共通利用
-- 文字コードで記述（Nerd Font の文字はコピー等で消えやすいため）
local diag_icons = {
	[vim.diagnostic.severity.ERROR] = "\u{f057}", -- nf-fa-times_circle
	[vim.diagnostic.severity.WARN] = "\u{f071}", -- nf-fa-warning
	[vim.diagnostic.severity.INFO] = "\u{f05a}", -- nf-fa-info_circle
	[vim.diagnostic.severity.HINT] = "\u{f0335}", -- nf-md-lightbulb
}

vim.diagnostic.config({
	-- メッセージはコード上に表示しない（波線＋サインのみ）。
	-- 見る時: ]d / [d（または ]g / [g）で移動 → ポップアップで全文表示
	--         gl → その行の診断をポップアップ表示（<C-w>d と同じ）
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
		text = diag_icons,
		numhl = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
			[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
			[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
			[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
		},
	},
})

-- その行の診断をポップアップ表示（カーソルを動かすと閉じる。もう一度 gl でポップアップ内へ移動）
vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Show diagnostic" })

-- 診断一覧
--   <space>a  : Telescope（lspconfig.lua 側で設定。gr / gi と同じ上下レイアウト）
--   <space>ta : location list
vim.keymap.set("n", "<space>ta", function()
	vim.diagnostic.setloclist()
end, { desc = "Diagnostics (loclist)" })
