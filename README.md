# MyVimrc back
This is my vimrc/nvim config file backup
---

## config file path
- vimrc path: ~/.vimrc
- nvimrc path: ~/.config/nvim/init.vim


## Plugin manager tool install guide
https://github.com/VundleVim/Vundle.vim


## confilg Plugin manager tool at vimrc
```shell
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" install plugin from github
" Plugin 'xxxx/bbbb'
" Plugin 'ssss/kkkkk'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
```

---

# My terminal setup
---

## plugins
1. [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)
2. [powerlevel10k](https://github.com/romkatv/powerlevel10k)
3. [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
4. [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions/tree/master)

## fonts
[nerd-fonts](https://github.com/ryanoasis/nerd-fonts/tree/master)


## file manager setup

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

```


#### config reference link
[reference](https://github.com/jarun/nnn/wiki/Usage#configuration)
