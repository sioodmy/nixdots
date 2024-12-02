language en_US.utf8

" leader key
let mapleader = "\<Space>"
let maplocalleader = "\<Space>"
nnoremap <Space> <Nop>

" Global statusline
set laststatus=3

" For orgmode links
set conceallevel=2
set concealcursor=nc

" 4 spaces tabs and indentation
set smartindent
set expandtab
set cursorline
set tabstop=4
set softtabstop=4
set shiftwidth=4
set splitright
set splitbelow

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader><leader> <cmd>Telescope git_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fn <cmd>Telescope orgmode search_headings<cr>
nnoremap <leader>fh <cmd>Telescope harpoon marks<cr>
nnoremap <leader>z  <cmd>ZenMode <cr>
nnoremap <leader>b  <cmd>Neotree toggle<cr>
nnoremap <leader>g <cmd>Git <cr>
nnoremap <leader>u <cmd>UndotreeToggle <cr>

nnoremap <leader>m <cmd>lua require("harpoon.mark").add_file()<cr>
nnoremap <leader>hp <cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>

nnoremap <leader>w <cmd>update <cr>

nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

nnoremap <leader><cr> <cmd>lua require("sixelpreview").current_line()<cr>

nnoremap <M-h> <cmd>bprevious<cr>
nnoremap <M-l> <cmd>bnext<cr>

xnoremap <leader>p "\"_dP

" Autoformat on save 
augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END

" Per language
augroup indentation
  autocmd!
  autocmd FileType vim setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType nix setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType scheme setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType racket setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

" line numbers
set number
set relativenumber

" spacing when scrolling
set scrolloff=4

" use system clipboard via xsel
" set clipboard+=unnamedplus
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <C-r><C-o>+

" we aint doing no mouse in nvim
set mouse=

" Set the cursor to a line after leaving
au VimLeave * set guicursor=a:ver100

" Fuck Ex mode
:map Q <Nop>

let g:transparent_enabled = v:true
let g:highlightedyank_highlight_duration = 3

" Comes from modeline
set noshowmode

" modeline magic
set modeline
