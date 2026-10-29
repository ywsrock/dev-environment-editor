# Dev Environment Editor

日本語 | [English](README.en.md)

Neovim・zsh・nnn などの設定ファイルのバックアップです。

## 目次

- [リポジトリ構成](#リポジトリ構成)
- [クイックスタート](#クイックスタート)
- [Neovim](#neovim)
  - [ファイル構成](#ファイル構成)
  - [インストール](#インストール)
  - [主要なキーマッピング](#主要なキーマッピング)
  - [主要プラグイン](#主要プラグイン)
  - [プラグイン管理（Vundle）](#プラグイン管理vundle)
- [ターミナル（zsh）](#ターミナルzsh)
- [ファイルマネージャー（nnn）](#ファイルマネージャーnnn)
- [fzf](#fzf)

---

## リポジトリ構成

```
.
├── my-config/
│   ├── .config/
│   │   ├── nvim_mason/      # Neovim 設定（現在のメイン：mason + 標準 LSP）
│   │   ├── nvim_coc/        # Neovim 設定（旧：coc.nvim 版）
│   │   ├── nvim/            # Neovim 設定（旧：単一 init.vim 版）
│   │   ├── nnn/             # nnn の quitcd スクリプト
│   │   ├── yazi/            # yazi のテーマ（flavors）
│   │   └── pip/             # pip.conf
│   ├── .gitconfig           # Git 設定
│   ├── .gitconfig_delta     # delta（diff 表示）用の Git 設定
│   └── .golangci.yml        # golangci-lint 設定
├── zsh/
│   ├── zshrc_local          # .zshrc（macOS / Homebrew 用）
│   └── zshrc_newzsh         # .zshrc（Linux 用、Oh My Zsh のプラグイン構成）
├── nnn/                     # nnn 設定（旧配置）
└── nvim/                    # Neovim 設定（旧配置）
```

## クイックスタート

```shell
cd <local repo>

# Neovim
cp -r my-config/.config/nvim_mason ~/.config/nvim

# nnn
cp -r my-config/.config/nnn ~/.config/nnn
```

Neovim は続けて [インストール](#インストール) の手順を実行してください。

---

## Neovim

### ファイル構成

```
my-config/.config/nvim_mason/
├── init.vim                 # エントリーポイント（mapleader定義、ファイル読み込み）
├── plugin/
│   ├── plugins.vim          # Vundle プラグイン定義
│   ├── options.vim          # 基本設定（encoding, tabstop, folding等）
│   ├── keymaps.vim          # キーマッピング
│   ├── fzf.vim              # fzf 設定
│   ├── startify.vim         # vim-startify 設定
│   └── vscode.vim           # VSCode Neovim 用設定
├── lua/
│   ├── config/
│   │   ├── mason.lua        # mason.nvim（LSP サーバー管理）
│   │   ├── lspconfig.lua    # LSP 設定 + キーマップ
│   │   ├── cmp.lua          # nvim-cmp（補完）
│   │   ├── conform.lua      # conform.nvim（フォーマッター）
│   │   └── treesitter.lua   # nvim-treesitter 設定
│   └── plugins/
│       ├── noice.lua        # noice.nvim + nvim-notify 設定
│       ├── telescope.lua    # Telescope 設定
│       └── md_preview.lua   # nvim-md-preview（Markdown プレビュー）設定
└── pack/github/start/
    └── copilot.vim          # GitHub Copilot
```

### インストール

```shell
# 設定ファイルをコピー
cp -r my-config/.config/nvim_mason ~/.config/nvim

# Vundle をインストール（初回のみ）
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Neovim を起動してプラグインをインストール
nvim +PluginInstall +qall
```

LSP サーバーは初回起動時に mason.nvim が自動インストールします（`:Mason` で確認）。

### 主要なキーマッピング

`<leader>` は `,` です。

**ファイル操作**

| キー | 機能 |
|------|------|
| `<C-t>` | NERDTree トグル |
| `,ff` | ファイル検索 (fzf) |
| `,fg` | Grep 検索 (fzf) |
| `,fb` | バッファ一覧 (fzf) |

**LSP**

| キー | 機能 |
|------|------|
| `gd` | 定義へジャンプ |
| `gr` | 参照一覧 |
| `K` | ドキュメント表示 |
| `,rn` | リネーム |
| `,f` | フォーマット (conform) |

**Git**

| キー | 機能 |
|------|------|
| `,gd` | Diffview を開く |
| `,gD` | Diffview を閉じる |
| `,gh` | ファイル履歴 |

**Markdown**

| キー | 機能 |
|------|------|
| `,ms` | プレビュー開始 |
| `,mc` | プレビュー停止 |
| `,mr` | プレビュー開始/停止の切り替え |
| `,md` | Git 差分表示の切り替え |

### 主要プラグイン

| プラグイン | 用途 |
|------------|------|
| mason.nvim / nvim-lspconfig | LSP サーバー管理・設定（Neovim 標準 LSP） |
| nvim-cmp / LuaSnip | 補完、スニペット |
| conform.nvim | フォーマッター（保存時自動フォーマット） |
| nvim-treesitter | シンタックスハイライト、テキストオブジェクト |
| fzf.vim / telescope.nvim | ファジーファインダー |
| NERDTree | ファイルエクスプローラー |
| vim-startify | スタートページ |
| noice.nvim | UI 改善（コマンドライン、通知） |
| nvim-md-preview | Markdown プレビュー |
| copilot.vim | GitHub Copilot |
| tokyonight.nvim | カラースキーム |

### プラグイン管理（Vundle）

https://github.com/VundleVim/Vundle.vim

| コマンド | 説明 |
|----------|------|
| `:PluginList` | インストール済みプラグイン一覧 |
| `:PluginInstall` | プラグインをインストール |
| `:PluginUpdate` | プラグインを更新 |
| `:PluginClean` | 未使用プラグインを削除 |

プラグインを追加するときは `plugin/plugins.vim` を編集し、`:PluginInstall` を実行します。

```vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" ここに追加
Plugin 'username/repository'

call vundle#end()
```

---

## ターミナル（zsh）

`zsh/` の `.zshrc` を `~/.zshrc` にコピーして使います。

| ファイル | 用途 |
|----------|------|
| `zsh/zshrc_local` | macOS 用（Homebrew でインストールしたプラグインを読み込む） |
| `zsh/zshrc_newzsh` | Linux 用（Oh My Zsh の `plugins=(...)` でプラグインを読み込む） |

### 使用ツール

| ツール | 用途 |
|--------|------|
| [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh) | zsh フレームワーク |
| [powerlevel10k](https://github.com/romkatv/powerlevel10k) | プロンプトテーマ |
| [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) | コマンドのシンタックスハイライト |
| [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) | 履歴からの入力候補 |
| [colorls](https://github.com/athityakumar/colorls#installation) | カラー表示の ls |
| [bat](https://github.com/sharkdp/bat) | シンタックスハイライト付きの cat |
| [fzf](https://github.com/junegunn/fzf) | ファジーファインダー |
| [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts) | アイコン入りフォント |

---

## ファイルマネージャー（nnn）

[nnn](https://github.com/jarun/nnn)（n³）は、軽量・ほぼ設定不要・高速なターミナルファイルマネージャーです。

### インストール

参考：[Installation](https://github.com/jarun/nnn/wiki/Usage#installation)

```shell
sudo apt-get install pkg-config libncursesw5-dev libreadline-dev
sudo make strip install
```

### プラグインのインストール

```shell
sh -c "$(curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs)"
```

### quitcd の設定

nnn を終了したときに、そのディレクトリへ `cd` するための設定です。

1. `my-config/.config/nnn/misc/quitcd` を `~/.config/nnn/misc/` にコピーします。
2. `.zshrc` または `.bashrc` に以下を追加します。

```shell
export NNN_PLUG='f:finder;o:fzopen;p:mocq;d:diffs;t:nmount;v:imgview;p:preview-tui'
alias nnn="nnn -e"

export NNN_MISC_QUITCD="$HOME/.config/nnn/misc/quitcd"

case "$SHELL" in
  */zsh)
    [ -f "$NNN_MISC_QUITCD/quitcd.bash_sh_zsh" ] && source "$NNN_MISC_QUITCD/quitcd.bash_sh_zsh"
    ;;
  */bash)
    [ -f "$NNN_MISC_QUITCD/quitcd.bash_sh_zsh" ] && source "$NNN_MISC_QUITCD/quitcd.bash_sh_zsh"
    ;;
  */csh)
    [ -f "$NNN_MISC_QUITCD/quitcd.csh" ] && source "$NNN_MISC_QUITCD/quitcd.csh"
    ;;
esac
```

設定項目の詳細：[Configuration](https://github.com/jarun/nnn/wiki/Usage#configuration)

---

## fzf

### シェル別の有効化

apt でインストールした場合、以下を各シェルの設定ファイルに追加します。

**Bash**（`~/.bashrc`）

```shell
source /usr/share/doc/fzf/examples/key-bindings.bash   # キーバインド
source /usr/share/doc/fzf/examples/completion.bash     # 補完
```

**Zsh**（`~/.zshrc`）

```shell
source /usr/share/doc/fzf/examples/key-bindings.zsh    # キーバインド
source /usr/share/doc/fzf/examples/completion.zsh      # 補完
```

**Fish**

```shell
mkdir -p ~/.config/fish/functions/
echo fzf_key_bindings > ~/.config/fish/functions/fish_user_key_bindings.fish
```

**Vim**（vimrc）

```vim
source /usr/share/doc/fzf/examples/fzf.vim
```

### カスタマイズ

<details>
<summary>.zshrc に追加する fzf / bat / colorls の設定</summary>

```shell
# fzf setting
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--height 50% --layout=reverse --border'

# CTRL-T - Paste the selected files and directories onto the command-line
# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# CTRL-R - Paste the selected command from history onto the command-line
# CTRL-/ to toggle small preview window to see the full command
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

# ALT-C - cd into the selected directory
# Print tree structure in the preview window
export FZF_ALT_C_OPTS="--preview 'tree -C {}'"

# If you install bat using apt, the name of the executable will be batcat instead of bat.
# mkdir -p ~/.local/bin
# ln -s /usr/bin/batcat ~/.local/bin/bat
export PATH="$HOME/.local/bin:$PATH"

# colorls
source $(dirname $(gem which colorls))/tab_complete.sh
alias lc='colorls -lA --sd'
```

</details>

> **macOS で Alt-C が効かない場合**
> iTerm2 の Preferences → Profiles → Keys で、Option キーの動作を `Esc+` に変更してください。
