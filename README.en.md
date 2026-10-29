# Dev Environment Editor

[日本語](README.md) | English

A backup of my Neovim, zsh, nnn and other configuration files.

## Contents

- [Repository layout](#repository-layout)
- [Quick start](#quick-start)
- [Neovim](#neovim)
  - [File layout](#file-layout)
  - [Installation](#installation)
  - [Key mappings](#key-mappings)
  - [Main plugins](#main-plugins)
  - [Plugin manager (Vundle)](#plugin-manager-vundle)
- [Terminal (zsh)](#terminal-zsh)
- [File manager (nnn)](#file-manager-nnn)
- [fzf](#fzf)

---

## Repository layout

```
.
├── my-config/
│   ├── .config/
│   │   ├── nvim_mason/      # Neovim config (current: mason + built-in LSP)
│   │   ├── nvim_coc/        # Neovim config (old: coc.nvim version)
│   │   ├── nvim/            # Neovim config (old: single init.vim version)
│   │   ├── nnn/             # nnn quitcd scripts
│   │   ├── yazi/            # yazi themes (flavors)
│   │   └── pip/             # pip.conf
│   ├── .gitconfig           # Git config
│   ├── .gitconfig_delta     # Git config for delta (diff viewer)
│   └── .golangci.yml        # golangci-lint config
├── zsh/
│   ├── zshrc_local          # .zshrc (macOS / Homebrew)
│   └── zshrc_newzsh         # .zshrc (Linux, plugins via Oh My Zsh)
├── nnn/                     # nnn config (old location)
└── nvim/                    # Neovim config (old location)
```

## Quick start

```shell
cd <local repo>

# Neovim
cp -r my-config/.config/nvim_mason ~/.config/nvim

# nnn
cp -r my-config/.config/nnn ~/.config/nnn
```

For Neovim, continue with the [Installation](#installation) steps.

---

## Neovim

### File layout

```
my-config/.config/nvim_mason/
├── init.vim                 # Entry point (defines mapleader, loads files)
├── plugin/
│   ├── plugins.vim          # Vundle plugin list
│   ├── options.vim          # Basic options (encoding, tabstop, folding, etc.)
│   ├── keymaps.vim          # Key mappings
│   ├── fzf.vim              # fzf settings
│   ├── startify.vim         # vim-startify settings
│   └── vscode.vim           # Settings for VSCode Neovim
├── lua/
│   ├── config/
│   │   ├── mason.lua        # mason.nvim (LSP server management)
│   │   ├── lspconfig.lua    # LSP settings + key mappings
│   │   ├── cmp.lua          # nvim-cmp (completion)
│   │   ├── conform.lua      # conform.nvim (formatter)
│   │   └── treesitter.lua   # nvim-treesitter settings
│   └── plugins/
│       ├── noice.lua        # noice.nvim + nvim-notify settings
│       ├── telescope.lua    # Telescope settings
│       └── md_preview.lua   # nvim-md-preview (Markdown preview) settings
└── pack/github/start/
    └── copilot.vim          # GitHub Copilot
```

### Installation

```shell
# Copy the config
cp -r my-config/.config/nvim_mason ~/.config/nvim

# Install Vundle (first time only)
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Start Neovim and install the plugins
nvim +PluginInstall +qall
```

mason.nvim installs the LSP servers automatically on first start (check with `:Mason`).

### Key mappings

`<leader>` is `,`.

**Files**

| Key | Action |
|-----|--------|
| `<C-t>` | Toggle NERDTree |
| `,ff` | Find files (fzf) |
| `,fg` | Grep (fzf) |
| `,fb` | List buffers (fzf) |

**LSP**

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | List references |
| `K` | Show documentation |
| `,rn` | Rename |
| `,f` | Format (conform) |

**Git**

| Key | Action |
|-----|--------|
| `,gd` | Open Diffview |
| `,gD` | Close Diffview |
| `,gh` | File history |

**Markdown**

| Key | Action |
|-----|--------|
| `,ms` | Start preview |
| `,mc` | Stop preview |
| `,mr` | Toggle preview |
| `,md` | Toggle Git diff in the preview |

### Main plugins

| Plugin | Purpose |
|--------|---------|
| mason.nvim / nvim-lspconfig | LSP server management and config (built-in LSP) |
| nvim-cmp / LuaSnip | Completion, snippets |
| conform.nvim | Formatter (format on save) |
| nvim-treesitter | Syntax highlighting, text objects |
| fzf.vim / telescope.nvim | Fuzzy finder |
| NERDTree | File explorer |
| vim-startify | Start screen |
| noice.nvim | UI improvements (command line, notifications) |
| nvim-md-preview | Markdown preview |
| copilot.vim | GitHub Copilot |
| tokyonight.nvim | Color scheme |

### Plugin manager (Vundle)

https://github.com/VundleVim/Vundle.vim

| Command | Description |
|---------|-------------|
| `:PluginList` | List installed plugins |
| `:PluginInstall` | Install plugins |
| `:PluginUpdate` | Update plugins |
| `:PluginClean` | Remove unused plugins |

To add a plugin, edit `plugin/plugins.vim` and run `:PluginInstall`.

```vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" Add here
Plugin 'username/repository'

call vundle#end()
```

---

## Terminal (zsh)

Copy one of the `.zshrc` files in `zsh/` to `~/.zshrc`.

| File | Purpose |
|------|---------|
| `zsh/zshrc_local` | macOS (loads plugins installed with Homebrew) |
| `zsh/zshrc_newzsh` | Linux (loads plugins through Oh My Zsh `plugins=(...)`) |

### Tools

| Tool | Purpose |
|------|---------|
| [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh) | zsh framework |
| [powerlevel10k](https://github.com/romkatv/powerlevel10k) | Prompt theme |
| [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) | Command syntax highlighting |
| [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) | Suggestions from history |
| [colorls](https://github.com/athityakumar/colorls#installation) | Colorized ls |
| [bat](https://github.com/sharkdp/bat) | cat with syntax highlighting |
| [fzf](https://github.com/junegunn/fzf) | Fuzzy finder |
| [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts) | Fonts with icons |

---

## File manager (nnn)

[nnn](https://github.com/jarun/nnn) (n³) is a full-featured terminal file manager. It's tiny, nearly 0-config and incredibly fast.

### Installation

See: [Installation](https://github.com/jarun/nnn/wiki/Usage#installation)

```shell
sudo apt-get install pkg-config libncursesw5-dev libreadline-dev
sudo make strip install
```

### Installing plugins

```shell
sh -c "$(curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs)"
```

### quitcd setup

This makes the shell `cd` into the last directory when you quit nnn.

1. Copy `my-config/.config/nnn/misc/quitcd` to `~/.config/nnn/misc/`.
2. Add the following to `.zshrc` or `.bashrc`:

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

All options: [Configuration](https://github.com/jarun/nnn/wiki/Usage#configuration)

---

## fzf

### Enabling it per shell

If fzf was installed with apt, add these lines to each shell's config file.

**Bash** (`~/.bashrc`)

```shell
source /usr/share/doc/fzf/examples/key-bindings.bash   # key bindings
source /usr/share/doc/fzf/examples/completion.bash     # completion
```

**Zsh** (`~/.zshrc`)

```shell
source /usr/share/doc/fzf/examples/key-bindings.zsh    # key bindings
source /usr/share/doc/fzf/examples/completion.zsh      # completion
```

**Fish**

```shell
mkdir -p ~/.config/fish/functions/
echo fzf_key_bindings > ~/.config/fish/functions/fish_user_key_bindings.fish
```

**Vim** (vimrc)

```vim
source /usr/share/doc/fzf/examples/fzf.vim
```

### Customization

<details>
<summary>fzf / bat / colorls settings for .zshrc</summary>

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

> **If Alt-C does not work on macOS**
> In iTerm2, go to Preferences → Profiles → Keys and set the Option key to `Esc+`.
