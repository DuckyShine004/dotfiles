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

" Lua linking
luafile ~/.config/nvim/lua/init.lua

" Formatting
let g:clang_format#auto_format = 1
let g:clang_format#auto_format_on_insert_leave = 0
let g:clang_format#code_style = "llvm"

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

" Run code command
function! RunCode()
    if &filetype == 'python'
        " Save the current file
        execute 'w'

        " Construct the command for running the Python script
        let run_python_cmd = 'python3 ' . shellescape(@%) . '; echo Press ENTER to exit; read line'

        " Construct the Floaterm command
        let floaterm_command = 'FloatermNew --name=RunPython --title=RunPython ' . run_python_cmd

        " Execute the Floaterm command
        execute floaterm_command

    elseif &filetype == 'cpp'
        " Save the current file
        execute 'w'

        " Define the executable name with .exe extension
        let executable = expand('%:r') . '.exe'

        " Construct the compile and run command
        let compile_and_run_cmd = 'g++ -Wall -Wextra -Wshadow -D_GLIBCXX_ASSERTIONS -fmax-errors=2 -o ' . shellescape(executable) . ' ' . shellescape(@%) . ' && ' . shellescape(executable) . '; echo Press ENTER to exit; read line'

        " Construct the Floaterm command
        let floaterm_command = 'FloatermNew --name=RunCpp --title=RunCpp ' . compile_and_run_cmd

        " Execute the Floaterm command
        execute floaterm_command

    elseif &filetype == 'tex'
        " Save the current file and compile LaTeX
        execute 'w'
        silent! VimtexCompile

    else
        echo "No run command for this filetype."
    endif
endfunction

" Debug code command
function! RunDebug()
    if &filetype == 'cpp'
        " Save the current file
        execute 'w'

        " Define the executable name with .exe extension
        let executable = expand('%:r') . '.exe'

        " Compile and run command
        let compile_and_run_cmd = 'g++ -Wall -Wextra -Wshadow -D_GLIBCXX_ASSERTIONS -DDEBUG -ggdb3 -fmax-errors=2 -o ' . shellescape(executable) . ' ' . shellescape(@%) . ' && ' . shellescape(executable) . '; echo Press ENTER to exit; read'

        " Construct the Floaterm command
        let floaterm_command = 'FloatermNew --name=Debug --title=Debug ' . compile_and_run_cmd

        " Execute the Floaterm command
        execute floaterm_command
    else
        echo "No debug command for this filetype."
    endif
endfunction

" Remaps
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fgc <cmd>Telescope git_commits<CR>
nnoremap <leader>fcb <cmd>Telescope current_buffer_fuzzy_find sorting_strategy=ascending ignore_case=false<CR>

" Keybinds
vnoremap <M-[> <gv
vnoremap <M-]> >gv
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
nnoremap <M-0> <cmd>only<CR>
nnoremap <M-v> <cmd>vsplit<CR>
nnoremap <M-h> <cmd>split<CR>

" Utilities
nnoremap <F2> <cmd>NvimTreeToggle<CR>
nnoremap <leader>ng <cmd>lua require('neogen').generate()<CR>

" Commentary
nnoremap <leader>/ :Commentary<CR>
vnoremap <leader>/ :Commentary<CR>

" Nvim tree
autocmd VimEnter * NvimTreeOpen

" Disable telescope background
augroup TelescopeTransparent
    autocmd!
    autocmd VimEnter * highlight TelescopeNormal guibg=NONE
    autocmd VimEnter * highlight TelescopeBorder guibg=NONE
augroup END

" Format files on save
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost * FormatWrite
augroup END

" Automatic filetype-specific configurations
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType css setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascriptreact setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType typescript setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType typescriptreact setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType json setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4 smarttab expandtab
