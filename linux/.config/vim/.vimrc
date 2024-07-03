" Note that I use this minimal vim configuration for competitive programming!

" Set leader key
let mapleader = "\<Space>"

" Plugins
call plug#begin('~/.vim/plugged')
    Plug 'preservim/nerdcommenter'
call plug#end()

set background=dark
colorscheme matrix

" set guifont=8514oem\ 15
set number
set cursorline
set clipboard=unnamed,unnamedplus
set completeopt=noinsert,menuone,noselect
set timeout timeoutlen=500 ttimeoutlen=500
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
set termguicolors
set nocursorline
set autoread
set backspace=indent,eol,start
set fillchars+=vert:\ 
set foldignore=

filetype plugin indent on
syntax on

" Reload configuration
nnoremap <C-r> :source ~/.config/vim/.vimrc<CR>

" Move selected text up and down in visual mode
vnoremap <S-K> :m '<-2<CR>gv=gv
vnoremap <S-J> :m '>+1<CR>gv=gv

" Indent and unindent in visual and normal mode
nnoremap <leader>[ <<
vnoremap <leader>[ <gv
nnoremap <leader>] >>
vnoremap <leader>] >gv

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

" Commenting
let g:NERDCreateDefaultMappings = 0

nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle

" Automatically update without focusing the window
augroup AutoRead
  autocmd!
  autocmd FocusGained,BufEnter * checktime
  autocmd CursorHold * checktime
augroup END
