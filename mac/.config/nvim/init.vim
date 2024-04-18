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
set encoding=utf-8
set guicursor=i:block

" CMD
set showcmd
set showmode
set noswapfile

" Tabs size
set expandtab
set smarttab
set autoindent
set shiftwidth=4
set tabstop=4

" Text and fonts
filetype plugin indent on
syntax on
set termguicolors
set background=dark

" Lua linking
luafile ~/.config/nvim/lua/init.lua

" Remaps
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fgc <cmd>Telescope git_commits<CR>
nnoremap <leader>fcb <cmd>Telescope current_buffer_fuzzy_find sorting_strategy=ascending ignore_case=false<CR>

" Keybinds
vnoremap <leader>t] <gv
vnoremap <leader>t[ >gv
nnoremap <C-a> ggVG
inoremap <C-H> <C-W>
nnoremap <C-b> <cmd>call RunCode()<CR>
nnoremap <C-d> <cmd>call RunDebug()<CR>
nnoremap <C-s> <cmd>w <CR>
nnoremap <C-q> <cmd>q <CR>
nnoremap <C-r> <cmd>w<CR>:source $MYVIMRC<CR>
vnoremap <C-I> :m '<-2<CR>gv=gv
vnoremap <C-K> :m '>+1<CR>gv=gv

" Splitting
nnoremap <leader>0s <cmd>only<CR>
nnoremap <leader>vs <cmd>vsplit<CR>
nnoremap <leader>hs <cmd>split<CR>

" Utilities
nnoremap <leader>op <cmd>NvimTreeToggle<CR>
nnoremap <leader>ng <cmd>lua require('neogen').generate()<CR>

" Commentary
nnoremap <leader>/ :Commentary<CR>
vnoremap <leader>/ :Commentary<CR>

" Go-to preview plugin
nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>
nnoremap gpt <cmd>lua require('goto-preview').goto_preview_type_definition()<CR>
nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>
nnoremap gpD <cmd>lua require('goto-preview').goto_preview_declaration()<CR>
nnoremap gpc <cmd>lua require('goto-preview').close_all_win()<CR>
nnoremap gpr <cmd>lua require('goto-preview').goto_preview_references()<CR>

" Nvim tree
autocmd VimEnter * NvimTreeOpen

" Disable telescope background
augroup TelescopeTransparent
    autocmd!
    autocmd VimEnter * highlight TelescopeNormal guibg=NONE
    autocmd VimEnter * highlight TelescopeBorder guibg=NONE
augroup END

" Formatting after save
augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost * FormatWrite
augroup END

" Automatic filetype-specific configurations
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType css setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType javascriptreact setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType typescript setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType typescriptreact setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType json setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4 smarttab expandtab
