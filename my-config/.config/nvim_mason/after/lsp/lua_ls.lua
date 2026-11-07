-- =============================================================================
-- lua_ls 個別設定（Neovim の設定・プラグイン開発用）
-- nvim-lspconfig 公式推奨（lsp/lua_ls.lua の説明）:
--   .luarc.json がある通常の Lua プロジェクトはそちらを優先し、
--   それ以外（Neovim 設定ディレクトリ等）では Neovim ランタイムを認識させる
-- =============================================================================
return {
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
}
