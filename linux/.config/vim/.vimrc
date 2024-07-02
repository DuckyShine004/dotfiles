" Note that I use this minimal vim configuration for competitive programming!

set background=dark
colorscheme quiet

set guifont=8514oem\ 15
set number
set cursorline
set clipboard=unnamed,unnamedplus
set completeopt=noinsert,menuone,noselect
set ttimeoutlen=0
set hidden
set noswapfile
set encoding=utf-8
set mouse=a
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set smartindent
set autochdir
set autoread
set nocompatible
set backspace=indent,eol,start

filetype plugin indent on
syntax on

nnoremap <C-r> :source ~/.config/vim/.vimrc<CR>

" Move selected text up and down in visual mode
vnoremap <S-K> :m '<-2<CR>gv=gv
vnoremap <S-J> :m '>+1<CR>gv=gv

" Indent and unindent in visual and normal mode
nnoremap <C-[> <<
nnoremap <C-]> >>
vnoremap <C-[> <gv
vnoremap <C-]> >gv

" Selecting everything
nnoremap <C-a> ggVG

" Rebinding pasting key in modes
inoremap <C-S-v> "+p
nnoremap <C-S-v> "+p
vnoremap <C-S-v> "+p

" Split windows
nnoremap <C-h> :split <CR><C-w>w
nnoremap <C-v> :vsplit <CR><C-w>w

" Split then open terminal in the split window
nnoremap <C-S-t> :sp<CR><C-w>J10<C-w>_:terminal ++curwin<CR>

" Automatically update without focusing the window
augroup AutoRead
  autocmd!
  autocmd FocusGained,BufEnter * checktime
  autocmd CursorHold * checktime
augroup END
