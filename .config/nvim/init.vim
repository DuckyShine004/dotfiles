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

call plug#begin('~/.local/share/nvim/plugged')
    " Appearance
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'ryanoasis/vim-devicons'
    Plug 'morhetz/gruvbox'
    Plug 'agude/vim-eldar'
    Plug 'bignimbus/pop-punk.vim'
    Plug 'xiyaowong/transparent.nvim'
    Plug 'glepnir/zephyr-nvim'
    Plug 'bluz71/vim-moonfly-colors', { 'as': 'moonfly' }
    Plug 'johnfrankmorgan/whitespace.nvim'
    Plug 'folke/which-key.nvim'
    Plug 'goolord/alpha-nvim'
    Plug 'folke/zen-mode.nvim'
    Plug 'folke/twilight.nvim'
    Plug 'folke/tokyonight.nvim'
    Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
    Plug 'dasupradyumna/midnight.nvim'

    " LaTeX
    Plug 'lervag/vimtex'

    " Commenting
    Plug 'numToStr/Comment.nvim'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'

    " Notifications
    Plug 'rcarriga/nvim-notify'

    " Managers
    Plug 'xolox/vim-colorscheme-switcher'
    Plug 'xolox/vim-misc'

    " Utilities
    Plug 'nvim-tree/nvim-tree.lua'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'sheerun/vim-polyglot'
    Plug 'iamcco/markdown-preview.nvim', {'do': 'cd app && npx --yes yarn install'}
    Plug 'mkropat/vim-ezguifont'
    Plug 'mg979/vim-visual-multi', {'branch': 'master'}
    Plug 'dstein64/nvim-scrollview'
    Plug 'akinsho/bufferline.nvim', { 'tag': '*' }

    " Linter / formatters
    Plug 'octol/vim-cpp-enhanced-highlight'
    Plug 'rhysd/vim-clang-format'
    Plug 'vim-syntastic/syntastic'
    Plug 'heavenshell/vim-pydocstring', {'do': 'make install', 'for': 'python'}
    Plug 'heavenshell/vim-jsdoc', {'do': 'make install', 'for': ['javascript', 'javascript.jsx','typescript']}
    Plug 'folke/trouble.nvim'
    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/mason.nvim'
    Plug 'williamboman/mason-lspconfig.nvim'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'mfussenegger/nvim-dap'
    Plug 'jay-babu/mason-nvim-dap.nvim'
    Plug 'rcarriga/nvim-dap-ui'
    Plug 'onsails/lspkind-nvim'
    Plug 'L3MON4D3/LuaSnip'
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'windwp/nvim-autopairs'

    " Syntax highlighting and other features for React
    Plug 'mxw/vim-jsx'
    Plug 'pangloss/vim-javascript'
    Plug 'lukas-reineke/indent-blankline.nvim'
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'nvim-tree/nvim-web-devicons'

    " Git
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'
    Plug 'rbong/vim-flog'
call plug#end()

" Lua linking
luafile ~/.config/nvim/lua/config.lua

" Load previous session colorscheme
if filereadable($HOME.'/.nvim_last_color_scheme')
    let g:colorscheme = readfile($HOME.'/.nvim_last_color_scheme')[0]
    execute 'colorscheme ' . g:colorscheme
endif

" Functions
let g:term_buf = 0
let g:term_win = 0

" Colorschemes
let g:colorschemes = ['gruvbox', 'pop-punk', 'zephyr', 'moonfly', 'midnight', 'tokyonight-night', 'tokyonight-moon', 'catppuccin-mocha']
let g:current_scheme_index = 0

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
        call system('gnome-terminal -- bash -c "python3 ' . shellescape(@%) . '; echo Press ENTER to exit; read line"')
    elseif &filetype == 'cpp'
        let executable = expand('%:r') . '.exe'
        execute 'w'
        call system('gnome-terminal -- bash -c "g++ -Wall -Wextra -Wshadow -D_GLIBCXX_ASSERTIONS -fmax-errors=2 -o ' . shellescape(executable) . ' ' . shellescape(@%) . ' && ' . shellescape(executable) . '; echo Press ENTER to exit; read line"')
        " call system('gnome-terminal -- bash -c "g++ ' . shellescape(@%) . ' -o ' . shellescape(executable) . ' && ./' . shellescape(executable) . '; echo Press ENTER to exit; read line"')
    elseif &filetype == 'tex'
        execute 'w'
        silent! VimtexCompile
    else
        echo "No run command for this filetype."
    endif
endfunction

" Debugging command
function! RunDebug()
    if &filetype == 'cpp'
        let executable = expand('%:r') . '.exe'
        execute 'w'
        call system('gnome-terminal -- bash -c "g++ -Wall -Wextra -Wshadow -D_GLIBCXX_ASSERTIONS -DDEBUG -ggdb3 -fmax-errors=2 -o ' . shellescape(executable) . ' ' . shellescape(@%) . ' && ' . shellescape(executable) . '; echo Press ENTER to exit; read line"')
    else
        echo "No debug command for this filetype."
    endif
endfunction

" Closing tab and buffers
function! CloseCurrentTabAndBuffer()
    let currentBuffer = bufnr('%')
    execute 'confirm bdelete ' . currentBuffer

    if tabpagenr('$') > 1
        execute 'tabclose'
    endif
endfunction

" Change colorscheme
function! CycleColorScheme()
    let g:current_scheme_index = (g:current_scheme_index + 1) % len(g:colorschemes)
    let g:colorscheme = g:colorschemes[g:current_scheme_index]
    echo 'Applying scheme: ' . g:colorscheme
    call execute('colorscheme ' . g:colorscheme)
    call SaveCurrentColorScheme()
endfunction

" Save colorscheme on exit
function! SaveCurrentColorScheme()
    let scheme = g:colorscheme
    call writefile([scheme], $HOME.'/.nvim_last_color_scheme')
endfunction

" Change tab size
function! ChangeTabSize()
    echo "Select Tab Size:"
    echo "1. 2 spaces"
    echo "2. 4 spaces"
    echo "3. 8 spaces"
    let choice = input("Enter your choice: ")

    if choice == '1'
        set tabstop=2 shiftwidth=2 expandtab
    elseif choice == '2'
        set tabstop=4 shiftwidth=4 expandtab
    elseif choice == '3'
        set tabstop=8 shiftwidth=8 expandtab
    else
        echo "Invalid choice"
    endif
endfunction

" Run files and keybinds
nnoremap <C-b> :call RunCode()<CR>
nnoremap <C-d> :call RunDebug()<CR>
nnoremap <C-s> :w <CR>
nnoremap <C-q> :q <CR>
nnoremap <C-r> :w<CR>:source $MYVIMRC<CR>

" Splitting
nnoremap <M-0> :only<CR>
nnoremap <M-v> :vsplit<CR>
nnoremap <M-h> :split<CR>

" Dynamic font sizing
nnoremap <silent> <C--> :DecreaseFont<CR>
nnoremap <silent> <C-=> :IncreaseFont<CR>
nnoremap <silent> <C-+> :IncreaseFont<CR>
nnoremap <silent> <C-0> :ResetFontSize<CR>

" Keybinds
vnoremap <M-[> <gv
vnoremap <M-]> >gv
vnoremap <leader>c "+y
vnoremap <Leader>x "+x
vnoremap <leader>v "+p
nnoremap <C-a> ggVG
inoremap <C-H> <C-W>
nnoremap <C-J> 0
nnoremap <C-L> $
nnoremap <C-I> ddkP
nnoremap <C-K> ddp
vnoremap <C-I> :m '<-2<CR>gv=gv
vnoremap <C-K> :m '>+1<CR>gv=gv

" Basic keybindings for Telescope
nnoremap <leader>f :Telescope find_files<CR>
nnoremap <leader>g :Telescope live_grep<CR>
nnoremap <leader>b :Telescope buffers<CR>
nnoremap <leader>h :Telescope help_tags<CR>
nnoremap <leader>gc :Telescope git_commits<CR>
nnoremap <leader>cb :Telescope current_buffer_fuzzy_find<CR>

" Debugging
nnoremap <silent> <leader>db :lua require'dap'.toggle_breakpoint()<CR>

" Utilities
nnoremap <F2> :NvimTreeToggle<CR>
nnoremap <F3> :call CycleColorScheme()<CR>
nnoremap <F6> :call ToggleTerminal(12)<CR>
nnoremap <leader>pds :Pydocstring<CR>
nnoremap <leader>jds :JsDoc<CR>

" Tabs
nnoremap <C-t> :tabnew<CR>
nnoremap <C-w> :call CloseCurrentTabAndBuffer()<CR>

" Custom transparency
" if g:colors_name == 'eldar'
"     highlight Normal guibg=black
"     highlight NonText guibg=black
" endif

" VimTex settings
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_method = 'latexmk'
let g:vimtex_quickfix_mode = 0
let g:vimtex_compiler_latexmk = {
    \ 'continuous': 1,
    \ 'callback': 1,
    \ 'build_dir': '',
    \ 'background': 1,
    \ 'view': 1,
    \ 'hooks': []
    \}

" Commenting
nnoremap <leader>/ :Commentary<CR>
vnoremap <leader>/ :Commentary<CR>

" Formatting
let g:clang_format#auto_format = 1
let g:clang_format#auto_format_on_insert_leave = 0
let g:clang_format#code_style = "llvm"
let g:pydocstring_doq_path = 'doq'
let g:pydocstring_formatter = 'google'

" Onedark Theme
let g:onedark_termcolors=256

" Colorschemes
let g:colorscheme_switcher_exclude = ['default', 'lunaperche', 'morning', 'pablo', 'industry', 'koehler', 'peachpuff', 'quiet', 'murphy', 'ron', 'shine', 'slate', 'torte', 'habamax', 'zellner', 'blue', 'darkblue', 'delek', 'desert', 'eldar', 'elflord', 'evening']

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
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#tabline#tabs_label = 'Tabs'

" Gitgutter
let g:gitgutter_async = 1
let g:gitgutter_realtime = 1

" Manual commands
command! ChangeTabSize call ChangeTabSize()

" Nvim tree
autocmd VimEnter * NvimTreeOpen

" Colorschemes
autocmd VimLeave * call SaveCurrentColorScheme()

" Automatic filetype-specific configurations
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType css setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascriptreact setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType typescript setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType typescriptreact setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType json setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4 smarttab expandtab
