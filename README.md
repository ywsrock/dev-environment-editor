# myVimrc
This is my vimrc/nvim config file backup

### config file path
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

***

# My terminal line file manager setup


## terminal file mamager
nnn (n³) is a full-featured terminal file manager. It's tiny, nearly 0-config and incredibly fast.
[nnn](https://github.com/jarun/nnn)


## install nnn

[install](https://github.com/jarun/nnn/wiki/Usage#installation)

```shell
sudo apt-get install pkg-config libncursesw5-dev libreadline-dev
sudo make strip install
```

### install plugin

```shell
sh -c "$(curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs)"
```


## quitcd setup
- copy the nnn/misc/quite folder to ~/.config/nnn/misc

## config .zshrc or .bashrc
add the following to the shell rc file:

```shell
export NNN_PLUG='f:finder;o:fzopen;p:mocq;d:diffs;t:nmount;v:imgview;p:preview-tui'
alias nnn="nnn -e"

export NNN_MISC_QUITCD=~/.config/nnn/misc/quitcd

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



#### config reference link
[reference](https://github.com/jarun/nnn/wiki/Usage#configuration)
