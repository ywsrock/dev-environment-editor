-- =============================================================================
-- treesitter.lua - Treesitter 設定（nvim-treesitter main ブランチ / Neovim 0.12+）
-- =============================================================================
-- main ブランチでは機能ごとに Neovim 標準の仕組みを使う:
--   パーサー     : require("nvim-treesitter").install()（ビルドに tree-sitter CLI が必要。Mason で導入）
--   ハイライト   : vim.treesitter.start()（FileType で自動実行）
--   選択の拡大   : Neovim 0.12 標準（Visual モードで an / in。設定不要）
--   テキストobj  : nvim-treesitter-textobjects の関数を vim.keymap.set で割り当て
--
-- ショートカットキー:
--   [選択範囲の拡大 / 縮小]（Neovim 標準。v で選択を始めてから）
--     an / in   構文の単位で選択範囲を広げる / 狭める
--     ]n / [n   次 / 前の構文ノードを選択
--
--   [テキストオブジェクト]（Visual / Operator モード）
--     af / if   関数の外側 / 内側
--     ac / ic   クラスの外側 / 内側
--     aa / ia   引数の外側 / 内側
--     ai / ii   条件文の外側 / 内側
--     al / il   ループの外側 / 内側
--     a/        コメント
--     例: vaf → 関数全体を選択、dif → 関数の中身を削除、yaa → 引数をコピー
--
--   [移動]
--     ]m / [m   次 / 前の関数の先頭へ      ]M / [M   次 / 前の関数の末尾へ
--     ]] / [[   次 / 前のクラスの先頭へ    ][ / []   次 / 前のクラスの末尾へ
--     ]a / [a   次 / 前の引数へ
--
--   [入れ替え]
--     <Leader>sn / <Leader>sp   引数を次 / 前の引数と入れ替え
--
--   [その他]
--     <Leader>ct  画面上部のコンテキスト表示（今いる関数名など）の切り替え
--                 （,tc だと翻訳の ,t と重なり、,t を押してから1秒待たされるため ,ct）
--
-- コマンド:
--   :TSInstall <言語>   パーサーをインストール
--   :TSUpdate           全パーサーを更新
--   :TSUninstall <言語> パーサーを削除
--   :checkhealth nvim-treesitter   状態の確認
-- =============================================================================

local ok, ts = pcall(require, "nvim-treesitter")
if not ok then
	vim.notify("nvim-treesitter not installed. Run :PluginInstall", vim.log.levels.WARN)
	return
end

-- -----------------------------------------------------------------------------
-- パーサーのインストール（インストール済みなら何もしない。非同期で実行）
-- Windows は C コンパイラが必要なため自動インストールしない（必要な言語だけ :TSInstall）
-- -----------------------------------------------------------------------------
if vim.fn.has("win32") == 0 then
	ts.install({
		-- Neovim
		"lua",
		"vim",
		"vimdoc",
		"query",
		-- Web 開発
		"javascript",
		"typescript",
		"tsx",
		"html",
		"css",
		"scss",
		-- バックエンド
		"python",
		"go",
		"rust",
		"c_sharp",
		-- 設定ファイル
		"json",
		"yaml",
		"toml",
		"xml",
		-- シェル
		"bash",
		-- ドキュメント
		"markdown",
		"markdown_inline",
		-- データベース
		"sql",
		-- その他
		"dockerfile",
		"gitignore",
		"gitcommit",
		"diff",
		"regex",
		"comment",
	})
end

-- -----------------------------------------------------------------------------
-- テキストオブジェクト（nvim-treesitter-textobjects main ブランチ）
-- キーはパーサーがあるバッファだけに設定する（下の FileType で呼び出す）。
-- パーサーが無いファイルでは Vim 標準の ]] / [[ 等がそのまま使える
-- -----------------------------------------------------------------------------
local set_textobject_keymaps = function(_) end

local to_ok, textobjects = pcall(require, "nvim-treesitter-textobjects")
if to_ok then
	textobjects.setup({
		select = {
			lookahead = true, -- カーソルより後ろにある一番近いオブジェクトも選択できる
		},
		move = {
			set_jumps = true, -- 移動前の位置をジャンプリストに残す（<C-o> で戻れる）
		},
	})

	local select = require("nvim-treesitter-textobjects.select")
	local move = require("nvim-treesitter-textobjects.move")
	local swap = require("nvim-treesitter-textobjects.swap")

	-- 選択（Visual / Operator モード）
	local selects = {
		{ "af", "@function.outer", "関数の外側" },
		{ "if", "@function.inner", "関数の内側" },
		{ "ac", "@class.outer", "クラスの外側" },
		{ "ic", "@class.inner", "クラスの内側" },
		{ "aa", "@parameter.outer", "引数の外側" },
		{ "ia", "@parameter.inner", "引数の内側" },
		{ "ai", "@conditional.outer", "条件文の外側" },
		{ "ii", "@conditional.inner", "条件文の内側" },
		{ "al", "@loop.outer", "ループの外側" },
		{ "il", "@loop.inner", "ループの内側" },
		{ "a/", "@comment.outer", "コメント" },
	}

	-- 移動（Normal / Visual / Operator モード）
	local moves = {
		{ "]m", "goto_next_start", "@function.outer", "次の関数の先頭へ" },
		{ "]]", "goto_next_start", "@class.outer", "次のクラスの先頭へ" },
		{ "]a", "goto_next_start", "@parameter.inner", "次の引数へ" },
		{ "]M", "goto_next_end", "@function.outer", "次の関数の末尾へ" },
		{ "][", "goto_next_end", "@class.outer", "次のクラスの末尾へ" },
		{ "[m", "goto_previous_start", "@function.outer", "前の関数の先頭へ" },
		{ "[[", "goto_previous_start", "@class.outer", "前のクラスの先頭へ" },
		{ "[a", "goto_previous_start", "@parameter.inner", "前の引数へ" },
		{ "[M", "goto_previous_end", "@function.outer", "前の関数の末尾へ" },
		{ "[]", "goto_previous_end", "@class.outer", "前のクラスの末尾へ" },
	}

	set_textobject_keymaps = function(buf)
		for _, s in ipairs(selects) do
			vim.keymap.set({ "x", "o" }, s[1], function()
				select.select_textobject(s[2], "textobjects")
			end, { buffer = buf, desc = s[3] .. "を選択" })
		end
		for _, m in ipairs(moves) do
			vim.keymap.set({ "n", "x", "o" }, m[1], function()
				move[m[2]](m[3], "textobjects")
			end, { buffer = buf, desc = m[4] })
		end
		-- 入れ替え（引数の順番を変える）
		vim.keymap.set("n", "<Leader>sn", function()
			swap.swap_next("@parameter.inner")
		end, { buffer = buf, desc = "次の引数と入れ替え" })
		vim.keymap.set("n", "<Leader>sp", function()
			swap.swap_previous("@parameter.inner")
		end, { buffer = buf, desc = "前の引数と入れ替え" })
	end
end

-- -----------------------------------------------------------------------------
-- ファイルを開いた時: パーサーがある言語ならハイライトとキーを有効化
-- 大きいファイル（100 KB 超）は重くなるため、ハイライトだけ Vim 標準のまま
-- -----------------------------------------------------------------------------
local max_filesize = 100 * 1024

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("UserTreesitterStart", { clear = true }),
	callback = function(args)
		local lang = vim.treesitter.language.get_lang(args.match)
		if not lang or not pcall(vim.treesitter.language.add, lang) or not vim.treesitter.language.add(lang) then
			return -- パーサーが無い言語では何もしない
		end

		-- 関数・クラス等の定義（textobjects クエリ）がある言語だけキーを設定
		-- （help 等の定義が無い言語では Vim 標準の ]] 等をそのまま使う）
		if vim.treesitter.query.get(lang, "textobjects") then
			set_textobject_keymaps(args.buf)
		end

		local stats = vim.uv.fs_stat(vim.api.nvim_buf_get_name(args.buf))
		if not (stats and stats.size > max_filesize) then
			pcall(vim.treesitter.start, args.buf, lang)
		end
	end,
})

-- =============================================================================
-- nvim-treesitter-context 設定（画面上部に今いる関数名などを表示）
-- =============================================================================
local context_ok, treesitter_context = pcall(require, "treesitter-context")
if context_ok then
	treesitter_context.setup({
		enable = true, -- デフォルトで有効
		max_lines = 3, -- 表示する最大行数
		min_window_height = 0, -- 最小ウィンドウ高さ（0 = 制限なし）
		line_numbers = true, -- 行番号を表示
		multiline_threshold = 20, -- 複数行のコンテキストの最大行数
		trim_scope = "outer", -- 外側からトリミング
		mode = "cursor", -- 'cursor' or 'topline'
		separator = nil, -- セパレータ文字（nil = 非表示）
		zindex = 20, -- フローティングウィンドウの z-index
	})

	vim.keymap.set("n", "<Leader>ct", function()
		treesitter_context.toggle()
	end, { desc = "Treesitter Context のトグル" })
end

-- =============================================================================
-- rainbow-delimiters 設定（虹色括弧）
-- =============================================================================
local rainbow_ok, rainbow_delimiters = pcall(require, "rainbow-delimiters")
if rainbow_ok then
	vim.g.rainbow_delimiters = {
		strategy = {
			[""] = rainbow_delimiters.strategy["global"],
			vim = rainbow_delimiters.strategy["local"],
		},
		query = {
			[""] = "rainbow-delimiters",
			lua = "rainbow-blocks",
		},
		priority = {
			[""] = 110,
			lua = 210,
		},
		highlight = {
			"RainbowDelimiterRed",
			"RainbowDelimiterYellow",
			"RainbowDelimiterBlue",
			"RainbowDelimiterOrange",
			"RainbowDelimiterGreen",
			"RainbowDelimiterViolet",
			"RainbowDelimiterCyan",
		},
	}
end
