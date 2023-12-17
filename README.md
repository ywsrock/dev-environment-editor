# myVimrc
local .vimrc backup

## Plugin manager tool install guide
https://github.com/VundleVim/Vundle.vim

## install plugin mng
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim


## Option terminal file mamager
nnn 

### install plugin
sh -c "$(curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs)"

### config .zshrc
export NNN_PLUG='f:finder;o:fzopen;p:mocq;d:diffs;t:nmount;v:imgview;p:preview-tui'

#export NNN_OPENER=/usr/local/bin/nvim

alias nnn="nnn -e"


####
https://github.com/jarun/nnn/wiki/Usage#configuration
