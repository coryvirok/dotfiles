set ts=4 sw=4 expandtab autoindent backupcopy=yes
syntax enable
set background=dark

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
