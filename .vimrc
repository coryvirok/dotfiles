set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
Plugin 'andviro/flake8-vim'

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

set background=light
let g:solarized_termtrans=1
colorscheme solarized

autocmd BufRead,BufNewFile *.as set filetype=as3
autocmd BufRead,BufNewFile *.mako set filetype=html ts=2 sw=2 expandtab
autocmd BufRead,BufNewFile *.dbtmako set filetype=html ts=2 sw=2 expandtab
autocmd BufRead,BufNewFile *.less set filetype=css ts=2 sw=2 expandtab
autocmd BufRead,BufNewFile *.rb set filetype=ruby ts=2 sw=2 expandtab
autocmd BufRead,BufNewFile *.py set filetype=python ts=4 sw=4 expandtab
autocmd BufRead,BufNewFile *.json set filetype=javascript ts=2 sw=2 expandtab
autocmd BufRead,BufNewFile *.js set filetype=javascript ts=2 sw=2 expandtab
autocmd BufRead,BufNewFile *.jsx set filetype=javascript ts=2 sw=2 expandtab
autocmd BufRead,BufNewFile *.coffee setl foldmethod=indent nofoldenable
autocmd BufRead,BufNewFile *.coffee setl sw=2 expandtab
autocmd BufRead,BufNewFile *.sql set filetype=sql ts=2 sw=2 expandtab
autocmd BufRead,BufNewFile *.html.erb set filetype=html ts=2 sw=2 expandtab

filetype plugin on

syntax enable

let g:PyFlakeOnWrite = 1
let g:PyFlakeCheckers = 'pep8,mccabe,frosted'
