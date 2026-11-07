# Neovim 設定

Neovim 標準の LSP、補完（nvim-cmp）、フォーマッター（conform.nvim）、Treesitter を使った開発用の設定です。
LSP サーバーとフォーマッターは Mason で自動インストールされます。

- 対象: **Neovim 0.12 以上**（macOS / Linux / Windows）
- プラグイン管理: Vundle
- リーダーキー: `,`（カンマ）

---

## 目次

1. [必要なもの](#1-必要なもの)
2. [インストール手順](#2-インストール手順)
3. [フォルダー構成](#3-フォルダー構成)
4. [よく使うキー操作](#4-よく使うキー操作)
5. [LSP の追加・設定・削除](#5-lsp-の追加設定削除)
6. [フォーマッターの追加](#6-フォーマッターの追加)
7. [診断（エラー・警告）の表示を変える](#7-診断エラー警告の表示を変える)
8. [更新方法](#8-更新方法)
9. [困ったとき](#9-困ったとき)

---

## 1. 必要なもの

### 必須

| ツール | 用途 | macOS（Homebrew）でのインストール例 |
|---|---|---|
| Neovim 0.12 以上 | 本体 | `brew install neovim` |
| git | プラグインのダウンロード | `brew install git` |
| Node.js / npm | 多くの LSP（TypeScript、JSON、CSS、HTML など）と prettier | `brew install node` |
| fzf | ファイル検索（`,ff`） | `brew install fzf` |
| ripgrep | 文字列検索（`,fg`） | `brew install ripgrep` |
| tree-sitter CLI（0.26.1 以上） | Treesitter のパーサーのビルド | `brew install tree-sitter-cli`（**npm 版は不可**） |
| C コンパイラ / curl / tar | Treesitter のパーサーのビルド | macOS は `xcode-select --install` |
| **Nerd Font** | アイコンの表示 | `brew install --cask font-hack-nerd-font` など |

> **Nerd Font について**: インストールしたあと、**ターミナルのフォントを Nerd Font に変更**してください。
> 変更しないと、アイコンが `□` や `?` で表示されます。

### 使う言語に合わせて必要なもの

| 言語 | 必要なもの | インストール例 |
|---|---|---|
| Go | Go 本体（gopls / goimports / gofumpt のインストールに使用） | `brew install go` |
| Rust | rustup（cargo と clippy。診断は clippy の結果を表示します） | `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \| sh`（公式のインストーラー） |
| Python | Python 3（black / isort のインストールに使用） | `brew install python` |
| C# | .NET SDK | `brew install --cask dotnet-sdk` |
| PowerShell | PowerShell（`pwsh`） | `brew install --cask powershell` |

使わない言語のツールは、インストールしなくてかまいません。その言語の LSP がインストールに失敗するだけで、ほかの言語には影響しません。

### Linux の場合

- クリップボード連携のため、`xclip`（X11）または `wl-clipboard`（Wayland）が必要です。
- Mason がツールをダウンロード・展開するため、`curl`（または `wget`）、`unzip`、`tar`、`gzip` が必要です。
- そのほかのツールは、各ディストリビューションのパッケージマネージャーでインストールしてください。

---

## 2. インストール手順

### macOS / Linux

```sh
# 1. 既存の設定があればバックアップ
mv ~/.config/nvim ~/.config/nvim.bak

# 2. この設定フォルダーを ~/.config/nvim に配置（init.vim が ~/.config/nvim/init.vim になるように）
#    例: git clone <この設定のリポジトリ URL> ~/.config/nvim

# 3. Vundle（プラグイン管理）をインストール
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# 4. プラグインをインストール
#    -u でプラグインの一覧（plugins.vim）だけを読み込んで起動する。
#    普通に nvim を起動すると、プラグインがまだ無いため「module 'cmp' not found」などのエラーが出る
nvim -u ~/.config/nvim/plugin/plugins.vim +PluginInstall +qall

# 5. Treesitter のパーサーをインストール（Vundle は自動では実行しないため）
nvim +TSUpdate

# 6. （Markdown プレビューを使う人のみ）プレビュー用のプログラムをダウンロード
nvim +MdPreviewInstall
```

### Windows

- 設定フォルダーは `%LOCALAPPDATA%\nvim`（`$HOME\AppData\Local\nvim`）に置きます。
- Vundle は `~/vimfiles/bundle/Vundle.vim` にインストールします。

```powershell
git clone https://github.com/VundleVim/Vundle.vim.git $HOME\vimfiles\bundle\Vundle.vim
nvim -u $HOME\AppData\Local\nvim\plugin\plugins.vim +PluginInstall +qall
```

Windows では、Treesitter のパーサーは自動ではインストールされません（`treesitter.lua` の設定）。必要な言語だけ `:TSInstall <言語名>` でインストールしてください。

### 初回起動

1. `nvim` を起動します。
2. **Mason が LSP サーバーとフォーマッターを自動でインストールします**（数分かかります）。進み具合は `:Mason` で確認できます。
3. インストールが終わったら、Neovim を開き直します。

### 動作確認

| 確認すること | 方法 |
|---|---|
| 全体の状態 | `:checkhealth` |
| LSP がつながっているか | 対象の言語のファイルを開いて `:checkhealth vim.lsp`（「Active Clients」に名前が出れば OK） |
| LSP とフォーマッターのインストール状況 | `:Mason` |
| フォーマッターの状態 | `:ConformInfo` |

### （任意）GitHub Copilot

Copilot 用のキーマップ（`plugin/keymaps.vim`）は設定済みです。プラグインは Vundle では管理していないので、使う人だけ次のコマンドでインストールしてください。

```sh
# macOS / Linux
git clone https://github.com/github/copilot.vim ~/.config/nvim/pack/github/start/copilot.vim
# Windows
git clone https://github.com/github/copilot.vim $HOME\AppData\Local\nvim\pack\github\start\copilot.vim
```

インストールしたら、Neovim で `:Copilot setup` を実行してログインします。

---

## 3. フォルダー構成

```
~/.config/nvim/
├── init.vim                 # エントリーポイント（読み込み順・カラースキーム）
├── README.md                # このファイル
├── plugin/                  # 自動で読み込まれる Vim script
│   ├── plugins.vim          # プラグインの一覧（Vundle）
│   ├── options.vim          # 基本設定（インデント、行番号など）
│   ├── keymaps.vim          # キーマッピング（LSP 以外）
│   ├── fzf.vim              # fzf の設定
│   ├── startify.vim         # 起動画面
│   └── vscode.vim           # VSCode（vscode-neovim）用の設定
├── lua/config/
│   ├── mason.lua            # ★ LSP・フォーマッターの一覧（追加はここ）
│   ├── lspconfig.lua        # LSP の共通設定とキーマップ
│   ├── diagnostic.lua       # 診断（エラー・警告）の表示
│   ├── cmp.lua              # 補完
│   ├── conform.lua          # ★ フォーマッターの割り当て
│   └── treesitter.lua       # Treesitter
├── lua/plugins/             # 個別プラグインの設定（noice / telescope / md_preview）
└── after/lsp/               # ★ LSP サーバーごとの個別設定（必要なものだけ）
    ├── rust_analyzer.lua
    ├── lua_ls.lua
    └── omnisharp.lua
```

★ の付いたファイルが、LSP を追加・設定するときに編集するファイルです。

---

## 4. よく使うキー操作

リーダーキーは `,` です（例: `,ff` は「カンマ、f、f」の順に押します）。

### 保存・基本

| キー | 動作 |
|---|---|
| `Ctrl-s` | 保存（ノーマル / 挿入 / ビジュアル。挿入モードは抜けません） |
| `Esc` `Esc` | 検索のハイライトを消す |

### LSP（コードの移動・情報）

| キー | 動作 |
|---|---|
| `gd` | 定義へジャンプ |
| `gy` | 型の定義へジャンプ |
| `gi` | 実装へジャンプ（1件ならそのままジャンプ、複数なら一覧） |
| `gr` | 参照の一覧（Telescope。`Ctrl-q` で quickfix に送る） |
| `K` | ドキュメントの表示 |
| `,rn` | 名前の変更（リネーム） |
| `,ac` / `,a` | コードアクション（`,a` はビジュアルモードでも使えます） |
| `,f` | フォーマット |
| `,ih` | inlay hints（型・引数名のヒント）の表示切り替え |
| `<Space>o` | 今のファイルのシンボル一覧（関数など） |
| `<Space>s` | ワークスペース全体のシンボル検索 |

### 診断（エラー・警告）

ふだんは波線と、行番号の横のアイコンだけが表示されます。

| キー | 動作 |
|---|---|
| `]d` / `[d` | 次 / 前の診断へ移動し、メッセージをポップアップで表示（`]g` / `[g` も同じ） |
| `gl` | その行の診断をポップアップで表示（もう一度 `gl` でポップアップの中に移動し、コピーできます） |
| `<Space>a` | 今のファイルの診断の一覧（Telescope） |
| `<Space>ta` | 診断の一覧（location list） |

### 補完（挿入モード）

| キー | 動作 |
|---|---|
| `Tab` / `Shift-Tab` | 次 / 前の候補（スニペットの中では次 / 前の入力位置へ） |
| `Enter` | 候補を決定 |
| `Ctrl-Space` | 補完を手動で開く |
| `Ctrl-e` | 補完を閉じる |
| `Ctrl-b` / `Ctrl-f` | ドキュメントをスクロール |

### 検索・ファイル

| キー | 動作 |
|---|---|
| `,ff` | ファイル検索（fzf） |
| `,fg` | 文字列検索（ripgrep） |
| `,fb` | 開いているバッファの一覧 |
| `,h` | コマンドの履歴 |
| `Ctrl-t` | ファイルツリー（NERDTree）の表示切り替え |
| `Ctrl-f` | 今のファイルをファイルツリーで表示 |

fzf の画面の中では、`Ctrl-v` で縦分割、`Ctrl-x` で横分割、`Ctrl-t` で新しいタブで開きます。`Ctrl-y` でパスをコピー、`Ctrl-q` で quickfix に送れます。

Telescope の画面の中でも、`Ctrl-v` / `Ctrl-x` / `Ctrl-t` で同じように開けます。

quickfix / location list のウィンドウの中では、`gs` でカーソル行をプレビュー、`gc` でプレビューを閉じます。

### Git（Diffview）

| キー | 動作 |
|---|---|
| `,gd` / `,gD` | 差分を開く / 閉じる |
| `,gh` | リポジトリの履歴 |
| `,gH` | 今のファイルの履歴 |

### コメント

Neovim の標準機能です（プラグインは使っていません）。
コメントにする操作と外す操作は同じキーで、押すたびに切り替わります。
コメントの記号は言語に合わせて自動で切り替わります（Rust / TS は `//`、Lua は `--`、Python / Shell は `#`、HTML は `<!-- -->`）。

| キー | 動作 |
|---|---|
| `gcc` | 今の行をコメント / コメント解除 |
| `3gcc` | 今の行から下に3行をまとめて切り替え（数字は自由） |
| `gcj` / `gck` | 今の行と次の行 / 前の行（2行） |
| `gc3j` | 今の行から下に4行 |
| `gcip` | 段落（空行で区切られたまとまり） |
| `V` で選択 → `gc` | 選んだ範囲をコメント / コメント解除 |
| `dgc` / `ygc` / `vgc` | カーソルがあるコメントのかたまりを 削除 / コピー / 選択 |

- `.` で直前の操作をくり返せます（例: `gcc` のあと `j.` で、次の行も切り替え）。
- 詳しい説明は `:help commenting` で読めます。

### コード編集（Treesitter）

| キー | 動作 |
|---|---|
| `Enter` / `Backspace` | 選択範囲を構文の単位で広げる / 狭める |
| `vaf` / `vif` | 関数の全体 / 中身を選択（`ac` / `ic` はクラス、`aa` / `ia` は引数） |
| `]m` / `[m` | 次 / 前の関数へ移動 |
| `,tc` | 画面上部のコンテキスト表示（今いる関数名など）の切り替え |

そのほかのキーは、`plugin/keymaps.vim` と `lua/config/treesitter.lua` の先頭のコメントにまとめてあります。

---

## 5. LSP の追加・設定・削除

### 今使っている LSP

| 言語 | サーバー名 | 言語 | サーバー名 |
|---|---|---|---|
| TypeScript / JavaScript | `ts_ls`, `eslint` | Go | `gopls` |
| HTML / CSS | `html`, `cssls` | Rust | `rust_analyzer` |
| Tailwind CSS | `tailwindcss` | Python | `pyright` |
| Emmet | `emmet_language_server` | Lua | `lua_ls` |
| JSON / YAML / TOML | `jsonls`, `yamlls`, `taplo` | C# | `omnisharp` |
| XML | `lemminx` | Bash | `bashls` |
| Dockerfile | `dockerls` | Vim script | `vimls` |
| Perl | `perlnavigator` | PowerShell | `powershell_es` |

### LSP を追加する

**手順 1. サーバー名を調べる**

Neovim で `:help lspconfig-all` を開き、`/` で言語名を検索します（例: `/kotlin`）。
見出しの名前（例: `kotlin_language_server`）が、設定に書く **サーバー名** です。

> `:Mason` の画面に出る名前（例: `kotlin-language-server`）とは書き方が違うことがあります。
> 設定に書くのは `lspconfig-all` の方の名前です。

**手順 2. `lua/config/mason.lua` に追加する**

`ensure_installed` の中に1行追加します。

```lua
ensure_installed = {
	-- ...
	"kotlin_language_server", -- Kotlin
},
```

**手順 3. Neovim を開き直す**

- Mason が自動でインストールし、その言語のファイルを開いたときに自動で起動します。
- キーマップ（`gd` / `gr` / `K` など）と補完は、自動で使えるようになります。

**手順 4. 確認する**

その言語のファイルを開いて `:checkhealth vim.lsp` を実行します。「Active Clients」にサーバー名が出ていれば成功です。

### LSP の個別設定をする（必要なときだけ）

標準の設定で足りるなら、この手順は不要です。

**手順 1. `after/lsp/<サーバー名>.lua` を作る**

例: Go で staticcheck を有効にする場合（`after/lsp/gopls.lua`）

```lua
return {
	settings = {
		gopls = {
			staticcheck = true,
		},
	},
}
```

- ここに書いた内容は、nvim-lspconfig の標準の設定に **自動で組み合わされます**（`require` などは不要）。
- 書ける項目は、`:help lspconfig-all` のそのサーバーの説明に載っています。
- 標準の設定の中身は `~/.vim/bundle/nvim-lspconfig/lsp/<サーバー名>.lua` で確認できます。
- 書き方の見本として、`after/lsp/rust_analyzer.lua` を参考にしてください。

**手順 2. Neovim を開き直す**

### LSP を削除する

1. `lua/config/mason.lua` の `ensure_installed` から、その行を削除します。
2. `:Mason` を開き、そのサーバーにカーソルを合わせて `X` を押してアンインストールします。
   （インストールされたまま残っていると、自動で起動してしまいます）
3. `after/lsp/<サーバー名>.lua` を作っていた場合は、そのファイルも削除します。

### LSP を起動させたくない（インストールは残したい）

`lua/config/mason.lua` の `automatic_enable.exclude` にサーバー名を追加します。

```lua
automatic_enable = {
	exclude = { "stylua", "サーバー名" },
},
```

---

## 6. フォーマッターの追加

保存するときに自動でフォーマットされます（`,f` で手動でも実行できます）。

**手順 1. `lua/config/conform.lua` の `formatters_by_ft` に追加**

```lua
formatters_by_ft = {
	-- ...
	kotlin = { "ktlint" },
},
```

複数書くと、順番に実行されます（例: `go = { "goimports", "gofumpt" }`）。

**手順 2. `lua/config/mason.lua` の `mason-tool-installer` の一覧に追加**

```lua
require("mason-tool-installer").setup({
	ensure_installed = {
		-- ...
		"ktlint",
	},
})
```

**手順 3. Neovim を開き直し、`:ConformInfo` で確認**

> フォーマッターの名前は `:Mason` の画面と、[conform.nvim の一覧](https://github.com/stevearc/conform.nvim#formatters) で確認できます。

---

## 7. 診断（エラー・警告）の表示を変える

診断の表示は `lua/config/diagnostic.lua` で設定しています。

今の設定では、コードの上にメッセージを表示せず、`]d` や `gl` でポップアップを開いて見ます。
ほかの表示方法（行末に表示する、カーソル行の下に表示する）に変える手順は、`diagnostic.lua` の `vim.diagnostic.config` の中にコメントで書いてあります。

> アイコンは文字コード（例: `"\u{f057}"`）で書いています。Nerd Font の文字はコピーすると消えやすいため、直接文字で書かないでください。

---

## 8. 更新方法

| 対象 | コマンド |
|---|---|
| プラグイン | `:PluginUpdate`（`plugins.vim` にプラグインを追加したときは `:PluginInstall`） |
| LSP / フォーマッター | `:Mason` を開いて `U`（すべて更新） |
| Treesitter のパーサー | `:TSUpdate` |

更新したら、Neovim を開き直してください。

---

## 9. 困ったとき

| 症状 | 確認・対処 |
|---|---|
| 起動すると `module '...' not found` や `Cannot find color scheme` のエラーが出る | プラグインがインストールされていません。[2. インストール手順](#2-インストール手順) の手順 4 を実行します |
| LSP が動かない | `:checkhealth vim.lsp` でつながっているか確認します。つながっていなければ、`:Mason` でインストールされているか確認します。インストールのエラーは `:MasonLog` で確認できます |
| LSP のインストールに失敗する | 言語ごとのツール（Node.js / Go / Python など）が入っているか確認します（[1. 必要なもの](#1-必要なもの)） |
| アイコンが `□` で表示される | ターミナルのフォントを Nerd Font に変更します |
| `Plugin` のエラーが出る | Vundle がインストールされているか確認し、`:PluginInstall` を実行します |
| Treesitter のエラーが出る | `tree-sitter --version` で 0.26.1 以上か確認してから、`:TSUpdate` を実行します |
| `,ff` が動かない | `fzf --version` で fzf が入っているか確認します |
| 保存してもフォーマットされない | `:ConformInfo` で、そのファイルの種類にフォーマッターが割り当てられ、インストールされているか確認します |
| Rust の診断が出るまで時間がかかる | 診断は `cargo clippy` の結果を表示しているため、プロジェクト全体のビルドが終わるまで表示されません（2回目からはキャッシュで速くなります） |
| ほかの人と設定が違う動きをする | `:checkhealth` の結果と、`nvim --version` を比べます |

### 設計上の注意（設定を変更する人向け）

- **rust-analyzer の独自診断はオフにしています**（`after/lsp/rust_analyzer.lua` の `diagnostics.enable = false`）。オンにすると、cargo clippy の診断と同じエラーが2回表示されます。
- **stylua は LSP として起動しないようにしています**（`mason.lua` の `automatic_enable.exclude`）。stylua はフォーマッターとして使っていて、LSP として起動するとエラーで終了するためです。
- LSP のキーマップは `on_attach` ではなく **`LspAttach` の自動処理** で設定しています（`lspconfig.lua`）。こうすると、nvim-lspconfig の標準のコマンド（`:LspCargoReload`、`:LspEslintFixAll` など）が上書きされません。
- `options.vim` で `ambiwidth=double` を設定しています。罫線の文字をつなげて表示するプラグインの設定（fzf-lua の `border-fused` など）とは相性が悪いので注意してください。
