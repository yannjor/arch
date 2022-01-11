" Many options from: https://github.com/isacsund/dotfiles

" =============================================================================
" # PLUGINS
" =============================================================================

call plug#begin()

" VIM enhancements
Plug 'tpope/vim-fugitive'                       " Git wrapper
Plug 'preservim/nerdtree'                       " File tree
Plug 'Xuyuanp/nerdtree-git-plugin'              " Git integration in file tree
Plug 'preservim/nerdcommenter'                  " Commenting
Plug 'airblade/vim-gitgutter'                   " Git diffs in sign column
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'jiangmiao/auto-pairs'

" LSP (completion)
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'onsails/lspkind-nvim' " Fancy icons for completion
Plug 'ray-x/lsp_signature.nvim'

" Only because nvim-cmp _requires_ snippets
Plug 'hrsh7th/cmp-vsnip', {'branch': 'main'}
Plug 'hrsh7th/vim-vsnip'

" Telescope (fuzzy finder)
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Visual enhancements
Plug 'nvim-lualine/lualine.nvim'                " Status line
Plug 'kyazdani42/nvim-web-devicons'             " Icons
Plug 'gruvbox-community/gruvbox'                " Colorscheme
Plug 'sainnhe/gruvbox-material'                 " Modified gruvbox
Plug 'sainnhe/everforest'                       " Gruvbox-like colorscheme

" Language support
Plug 'lervag/vimtex'

call plug#end()

" =============================================================================
" # Editor settings
" =============================================================================

" Lua settings
lua << EOF
require('lsp')
require('plugins')
EOF

" Better display for messages
set cmdheight=2
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

filetype plugin indent on
set relativenumber         " Show line numbers relative to each other
set number                 " Show the current lines number w/ relative numbers around it
set noswapfile             " Don't create *.swp files
set showcmd                " Display an incomplete command in the lower right corner
set mouse=a                " Allow scrolling/visual mode with mouse; Cmd-R to disable in Terminal
set clipboard+=unnamedplus " Always use system clipboard
set title                  " Window title

" Decent wildmenu
set wildmode=list:longest " Tab complete to longest common string, like bash

" Searching
set nohlsearch    " Don't highlight searches
set ignorecase    " Ignore case
set smartcase     " Override 'ignorecase' option if the search contains upper case characters.

" Indentation
set shiftwidth=4  " Number of spaces to use in each autoindent step
set tabstop=4     " Two tab spaces
set softtabstop=4 " Number of spaces to skip or insert when <BS>ing or <Tab>ing
set expandtab     " Spaces instead of tabs for better cross-editor compatibility

" Color column at 80 characters
set colorcolumn=80
" set textwidth=80

" Show white space
set listchars=eol:¬,tab:>·,trail:·,extends:>,precedes:<,space:·
set list

" 24bit true color
set termguicolors

" Colors
let g:gruvbox_material_background = 'hard'
colorscheme gruvbox-material

" colorscheme gruvbox
" let g:gruvbox_contrast_dark = 'hard'

" colorscheme everforest
" set background=dark
" let g:everforest_background = 'hard'

syntax enable
" Transparency
" hi Normal guibg=NONE ctermbg=NONE

" Leader key
let mapleader = " "

" Plugin settings
let g:NERDSpaceDelims = 1
let g:vimtex_view_method = 'zathura'
let g:vimtex_quickfix_mode = 0
" Ignore default mappings, define own
let g:vimtex_mappings_enabled = 0

" =============================================================================
" # Mappings
" =============================================================================

" Git
nnoremap <leader>grom :Git rebase origin/master<CR>
nnoremap <leader>grum :Git rebase upstream/master<CR>
nmap <leader>gj :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>
nmap <leader>gs :G<CR>

" Quick-save
nmap <leader>w :w<CR>

" Quickly insert an empty new line without entering insert mode
nnoremap <leader>o o<Esc>
nnoremap <leader>O O<Esc>

" Random remaps
nnoremap Y y$
nnoremap cn *``cgn
nnoremap cN *``cgN

" Move lines
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap <leader>k :m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==
inoremap <C-k> <esc>:m .-2<CR>==
inoremap <C-j> <esc>:m .+1<CR>==

" Telescope
nnoremap <C-p> <cmd>Telescope git_files<cr>
nnoremap <leader>tf <cmd>Telescope find_files<cr>
nnoremap <leader>tg <cmd>Telescope live_grep<cr>
nnoremap <leader>tb <cmd>Telescope buffers<cr>

" Surround
vnoremap <leader>' <esc>`>a'<esc>`<i'<esc>
vnoremap <leader>" <esc>`>a"<esc>`<i"<esc>
vnoremap <leader>( <esc>`>a)<esc>`<i(<esc>
vnoremap <leader>[ <esc>`>a]<esc>`<i[<esc>
vnoremap <leader>{ <esc>`>a}<esc>`<i{<esc>

" NerdTree
map <C-n> :NERDTreeToggle<CR>

" Commenter
vmap <leader>nc <plug>NERDCommenterToggle
nmap <leader>nc <plug>NERDCommenterToggle

" Vimtex
nnoremap <leader>ll :VimtexCompile<CR>
nnoremap <leader>lv :VimtexView<CR>
nnoremap <leader>lc :VimtexClean<CR>

" Spell-check
map <leader>se :setlocal spell! spelllang=en_us<CR>
map <leader>ss :setlocal spell! spelllang=sv<CR>
map <leader>sf :setlocal spell! spelllang=fr<CR>

" Completion: Jump forward or backward in snippets
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
