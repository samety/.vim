set number
set mouse=a
highlight LineNr ctermbg=DarkGrey
highlight Search ctermbg=DarkYellow

set expandtab
set tabstop=4
set shiftwidth=4
set smartindent
set noswapfile

set hlsearch
set incsearch

set nowrap

let mapleader=","

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

noremap <Leader>t :TagbarToggle<CR> 
noremap <Leader>f :silent vimgrep /\<<C-R><C-W>\>/j ./**/*.cc ./**/*.cpp ./**/*.h <Bar> :copen <CR>
noremap <Leader>d :silent vimgrep /\<<C-R><C-W>\>/j  <Bar> :cw <left><left><left><left><left><left><left>

vmap <Leader>b :<C-U>!svn blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

nnoremap <silent> <Leader>M :execute 'match Search /\%'.line('.').'l/'<CR>
nnoremap <silent> <Leader>m :execute 'match Search /\<<C-R><C-W>\>/'<CR>
nnoremap <silent> <Leader>l :nohlsearch<CR> :match<CR>

set makeprg=make\ -j\ 8\ -k\ -C\ Debug

runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
execute pathogen#helptags()
syntax on

autocmd BufWritePost .vimrc source $MYVIMRC
autocmd BufWritePre *.py retab

function! s:DiffSVN()
    let filetype=&ft
    diffthis
    vnew | exe "%!svn cat " . expand("#:p")
    diffthis
    exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
function! s:DiffOff()
    diffoff
    close
    diffoff
endfunction

com! DiffSVN call s:DiffSVN()
com! DiffOff call s:DiffOff()
