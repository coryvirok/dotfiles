#! /bin/bash

rsync -ahb ~/.vim/ ~/.vim.bak
rm -rf ~/.vim
ln -svf $PWD/.vim ~/.vim

rsync -ahb ~/.vimrc ~/.vimrc.bak
ln -svf $PWD/.vimrc ~/.vimrc

rsync -ahb ~/.tmux.conf ~/.tmux.conf.bak
ln -svf $PWD/.tmux.conf ~/.tmux.conf
