" Set leader key for shortcuts
let mapleader = " "

" Configurations for editor 
set clipboard^=unnamed,unnamedplus
set completeopt=noinsert,menuone,noselect
set cursorline
set hidden
set mouse=a
set number
set relativenumber
set title
set ttimeoutlen=0
set wildmenu

" Tabs size
set expandtab
set shiftwidth=2
set tabstop=2

call plug#begin('~/.local/share/nvim/plugged')
    " Appearance
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'ryanoasis/vim-devicons'
    Plug 'joshdick/onedark.vim'

    " Utilities
    Plug 'preservim/nerdtree'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'sheerun/vim-polyglot'

    " Linter / formatters
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'octol/vim-cpp-enhanced-highlight'
    Plug 'rhysd/vim-clang-format'
    Plug 'vim-syntastic/syntastic'

    " Syntax highlighting and other features for React
    Plug 'mxw/vim-jsx'
    Plug 'pangloss/vim-javascript'

    " Git
    Plug 'airblade/vim-gitgutter'
call plug#end()

" Functions
let g:term_buf = 0
let g:term_win = 0

function! ToggleTerminal(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction

" Function run code command
function! RunCode()
    if &filetype == 'python'
        execute 'w'
        execute '!python3 %'
    elseif &filetype == 'cpp'
        let executable = expand('%:r') . (has('win32') ? '.exe' : '')
        execute 'w'
        execute '!rm -f ' . shellescape(executable)
        execute '!g++ % -o ' . shellescape(executable) . ' && ./' . shellescape(executable)
    else
        echo "No run command for this filetype."
    endif
endfunction

" Text and fonts
filetype plugin indent on
syntax on
set termguicolors
colorscheme onedark

" Run files and keybinds
nnoremap <C-b> :call RunCode()<CR>
nnoremap <C-s> :w <CR>
nnoremap <C-q> :q <CR>
nnoremap <C-r> :w<CR>:source $MYVIMRC<CR> 

" Splitting
nnoremap <M-0> :only<CR>
nnoremap <M-v> :vsplit<CR>
nnoremap <M-h> :split<CR>

" Keybinds
nnoremap <C-a> ggVG
vnoremap <leader>c "+y
vnoremap <leader>v "+p
inoremap <C-H> <C-W>

" Basic keybindings for Telescope
nnoremap <leader>f :Telescope find_files<CR>
nnoremap <leader>g :Telescope live_grep<CR>
nnoremap <leader>b :Telescope buffers<CR>
nnoremap <leader>h :Telescope help_tags<CR>

" Utilities
nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <F6> :call ToggleTerminal(12)<CR>

" Tabs
nnoremap <C-t> :tabnew<CR>
nnoremap <C-w> :tabclose<CR>
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Onedark Theme
let g:onedark_termcolors=256

" NerdTree
let NERDTreeShowHidden=1

" Airline
set showtabline=2
set laststatus=2

" Airline Font
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''

" Airline Theme
let g:airline_theme='onedark'

" Airline Tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
let g:airline#extensions#tabline#formatter = 'default'

" Gitgutter
let g:gitgutter_async = 1
let g:gitgutter_realtime = 1

" Automatic commands
augroup auto_commands
    autocmd BufWrite *.py call CocAction('format')
    autocmd FileType scss setlocal iskeyword+=@-@
augroup END

