set number
set mouse=a

highlight LineNr cterm=None ctermbg=DarkGrey ctermfg=Yellow
highlight Search cterm=None ctermbg=DarkYellow ctermfg=Black

set tabstop=4
set shiftwidth=4
set smartindent
set noswapfile

set hlsearch
set incsearch

set list
highlight SpecialKey ctermfg=66

let mapleader=","

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

noremap <Leader>t :TagbarToggle<CR>

set wildignore+=./.build/**
set wildignore+=*.o,*.obj,*.pyc
set wildignore+=./venv/**
set wildignore+=./.venv/**
set wildignore+=./.venv3/**
set wildignore+=./.tox/**
set wildignore+=./*.egg-info/**

noremap <Leader>f :silent vimgrep /\<<C-R><C-W>\>/j ./**/*.cc ./**/*.cpp ./**/*.h ./**/*.inl ./**/*.proto ./**/*.py ./**/*.txt ./**/*.cmake ./**/*.xsd <Bar> :copen <CR>
noremap <Leader>d :silent vimgrep /\<<C-R><C-W>\>/j  <Bar> :cw <left><left><left><left><left><left><left>

nnoremap <silent> <Leader>M :execute 'match Search /\%'.line('.').'l/'<CR>
nnoremap <silent> <Leader>m :execute 'match Search /\<<C-R><C-W>\>/'<CR>
nnoremap <silent> <Leader>l :nohlsearch<CR> :match<CR>
imap <C-U> <Esc>gUiw`]a

set makeprg=make\ -j\ 8\ -k\ -C\ .build
noremap <F7> :AsyncRun make -j 8 -k -C .build <cr>

runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
execute pathogen#helptags()
syntax on

set nowrap

autocmd BufWritePost .vimrc source $MYVIMRC
" autocmd BufWritePre *.py retab
" autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab
autocmd FileType log set wrap
autocmd BufWinEnter * :filetype detect
autocmd BufWritePre *.cc :%s/\s\+$//e
autocmd BufWritePre *.h :%s/\s\+$//e
autocmd BufWritePost *.py call Flake8()

let g:flake8_show_in_gutter=1

function! s:SortGitModules()
	%s/\v\n\t/@@@/
	%sort
	%s/\v\@\@\@/\r\t/g
endfunction
com! SortGitModules call s:SortGitModules()

com! Ctag exe "!ctags -R --c++-kinds=+p --python-kinds=-i --exclude=*lib64* --exclude=*.css --exclude=*.json --exclude=Makefile --exclude=.venv3 --exclude=.venv --exclude=.tox ."

com! Pytest exe "!python setup.py test"

let $GCC_COLORS = ''
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

let @m = 'iMOC(f lvedh^wapa, f xf;i)j^'
