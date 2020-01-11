set nu rnu hls is nosol ts=4 sw=4 ch=2 sc
filetype indent plugin on
syntax on

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" set termguicolors
colorscheme one
set background=dark
let g:one_allow_italics = 1

autocmd BufNewFile,BufRead * syntax keyword Repeat FOR REP FORD REPD
autocmd BufNewFile,BufRead * syntax keyword Type LL
autocmd BufNewFile,BufRead * syntax keyword Type string vector tuple pair array deque set multiset unordered_set map unordered_map priority_queue
