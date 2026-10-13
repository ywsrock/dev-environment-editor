# Dev Environment Editor

This is my vimrc/nvim config file backup

---

## Vim/Neovim Configuration

### ファイル構成

```
my-config/.config/nvim_coc/
├── init.vim                 # エントリーポイント（mapleader定義、ファイル読み込み）
├── plugin/
│   ├── plugins.vim          # Vundle プラグイン定義
│   ├── options.vim          # 基本設定（encoding, tabstop, colorscheme等）
│   ├── keymaps.vim          # キーマッピング
│   ├── coc.vim              # coc.nvim 設定
│   ├── fzf.vim              # fzf 設定
│   ├── startify.vim         # vim-startify 設定
│   └── vscode.vim           # VSCode Neovim 用設定
├── lua/plugins/
│   └── noice.lua            # noice.nvim + nvim-notify 設定
└── plugins/
    ├── go/format.vim        # Go 言語用設定
    └── python/format.vim    # Python 用設定
```

### インストール

```shell
# 設定ファイルをコピー
cp -r my-config/.config/nvim_coc ~/.config/nvim

# Vundle をインストール（初回のみ）
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Neovim を起動してプラグインをインストール
nvim +PluginInstall +qall
```

### 主要なキーマッピング

| キー | 機能 |
|------|------|
| `<C-t>` | NERDTree トグル |
| `,ff` | ファイル検索 (fzf) |
| `,fg` | Grep検索 (fzf) |
| `,fb` | バッファ一覧 (fzf) |
| `gd` | 定義へジャンプ (coc) |
| `gr` | 参照一覧 (coc) |
| `K` | ドキュメント表示 (coc) |
| `<leader>rn` | リネーム (coc) |

### 主要プラグイン

- **coc.nvim** - LSP クライアント、補完
- **fzf.vim** - ファジーファインダー
- **NERDTree** - ファイルエクスプローラー
- **vim-startify** - スタートページ
- **noice.nvim** - UI改善（コマンドライン、通知）
- **tokyonight.nvim** - カラースキーム

## Plugin Manager: Vundle

https://github.com/VundleVim/Vundle.vim

### 基本コマンド

| コマンド | 説明 |
|----------|------|
| `:PluginList` | インストール済みプラグイン一覧 |
| `:PluginInstall` | プラグインをインストール |
| `:PluginUpdate` | プラグインを更新 |
| `:PluginClean` | 未使用プラグインを削除 |

### プラグインの追加方法

`plugin/plugins.vim` を編集:

```vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" ここに追加
Plugin 'username/repository'

call vundle#end()
```

その後 `:PluginInstall` を実行。

## 設定ファイルの使い方

```shell
cd <local repo>
cp -r my-config/.config/nvim_coc ~/.config/nvim
cp -r my-config/.config/nnn ~/.config/nnn
```

---

# Terminal Setup
---

## plugins
1. [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)
2. [powerlevel10k](https://github.com/romkatv/powerlevel10k)
3. [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
4. [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions/tree/master)
5. [colorls](https://github.com/athityakumar/colorls?tab=readme-ov-file#installation)
6. [bat](https://github.com/sharkdp/bat/tree/master)
7. [fzf](https://github.com/junegunn/fzf)

## Fonts
[nerd-fonts](https://github.com/ryanoasis/nerd-fonts/tree/master)


## File Manager: nnn

### terminal file mamager
nnn (n³) is a full-featured terminal file manager. It's tiny, nearly 0-config and incredibly fast.
[nnn](https://github.com/jarun/nnn)


### install nnn

[install](https://github.com/jarun/nnn/wiki/Usage#installation)

```shell
sudo apt-get install pkg-config libncursesw5-dev libreadline-dev
sudo make strip install
```

### install plugin

```shell
sh -c "$(curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs)"
```


### quitcd setup
- copy the nnn/misc/quite folder to ~/.config/nnn/misc

## config .zshrc or .bashrc
add the following to the shell rc file:

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


### fzf setup

ash
====

Append this line to ~/.bashrc to enable fzf keybindings for Bash:

```shell
   source /usr/share/doc/fzf/examples/key-bindings.bash
```

Append this line to ~/.bashrc to enable fuzzy auto-completion for Bash:

   source /usr/share/doc/fzf/examples/completion.bash

Zsh
===

Append this line to ~/.zshrc to enable fzf keybindings for Zsh:
```shell
   source /usr/share/doc/fzf/examples/key-bindings.zsh
```

Append this line to ~/.zshrc to enable fuzzy auto-completion for Zsh:

   source /usr/share/doc/fzf/examples/completion.zsh

Fish
====

Issue the following commands to enable fzf keybindings for Fish:
```shell
   mkdir -p ~/.config/fish/functions/
   echo fzf_key_bindings > ~/.config/fish/functions/fish_user_key_bindings.fish
```

Vim
===

The straightforward way to use fzf.vim is appending this line to your vimrc:
```shell
   source /usr/share/doc/fzf/examples/fzf.vim
```

Customize
===

```shell
# fzf setting
[ -f ‾/.fzf.zsh ] && source ‾/.fzf.zsh
export FZF_DEFAULT_OPTS='--height 50% --layout=reverse --border'

# CTRL-T - Paste the selected files and directories onto the command-lin
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
# Alt-C not working on mac OSX, so use c instead (Option + c)
# A: Go to Preferences->Profiles tab. Select your profile on the left, and then open the Keyboard tab.
# At the bottom is a set of buttons that lets you select the behavior of the Option key. 
# For most users, Esc+ will be the best choice.
# Print tree structure in the preview window
export FZF_ALT_C_OPTS="--preview 'tree -C {}'"

# If you install bat using apt, the name of the executable will be batcat instead of bat.
# (due to name conflicts with other packages) by setting up a symbolic link or alias of bat -> batcat,
# prevent problems caused by different executable names and be consistent with other distributions.
# mkdir -p ~/.local/bin
# ln -s /usr/bin/batcat ~/.local/bin/bat
export PATH="$HOME/.local/bin:$PATH"

#color ls
source $(dirname $(gem which colorls))/tab_complete.sh
alias lc='colorls -lA --sd'
```


#### config reference link
[reference](https://github.com/jarun/nnn/wiki/Usage#configuration)
