" Many options from: https://github.com/isacsund/dotfiles

" =============================================================================
" # PLUGINS
" =============================================================================
call plug#begin()

" VIM enhancements
Plug 'tpope/vim-fugitive'                       " Git wrapper
Plug 'neoclide/coc.nvim', {'branch': 'release'} " VSCode-like completion
Plug 'preservim/nerdtree'                       " File tree
Plug 'Xuyuanp/nerdtree-git-plugin'              " Git integration in file tree
Plug 'preservim/nerdcommenter'                  " Commenting
Plug 'airblade/vim-gitgutter'                   " Git diffs in sign column

" Telescope (fuzzy finder)
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Visual enhancements
Plug 'vim-airline/vim-airline'                  " Status line
Plug 'gruvbox-community/gruvbox'                " Best colorscheme

" Language support
Plug 'rust-lang/rust.vim'
Plug 'lervag/vimtex'

call plug#end()

" Rust
let g:rustfmt_autosave = 1

" Completion
" Better display for messages
set cmdheight=2
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" =============================================================================
" # Editor settings
" =============================================================================
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
set textwidth=80

" Show white space
set listchars=eol:¬,tab:>·,trail:·,extends:>,precedes:<,space:·
set list

" 24bit true color
set termguicolors

" Colors
colorscheme gruvbox
let g:gruvbox_contrast_dark = 'hard'
syntax enable
" Transparency
" hi Normal guibg=NONE ctermbg=NONE

" Leader key
let mapleader = " "

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
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>gb <cmd>Telescope git_branches<cr>

" COC configuration
" Use <tab> for trigger completion and navigate to the next complete item
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" COC extensions
let g:coc_global_extensions = [
  \ 'coc-rls',
  \ 'coc-pyright',
  \ 'coc-go',
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-pairs',
  \ 'coc-yaml',
  \ 'coc-json',
  \ ]

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" NerdTree
map <C-n> :NERDTreeToggle<CR>

" Commenter
let g:NERDSpaceDelims = 1
vmap <leader>nc <plug>NERDCommenterToggle
nmap <leader>nc <plug>NERDCommenterToggle

" Vimtex
let g:vimtex_view_method = 'zathura'
let g:vimtex_quickfix_mode = 0
" Ignore default mappings, define own
let g:vimtex_mappings_enabled = 0
nnoremap <leader>ll :VimtexCompile<CR>
nnoremap <leader>lv :VimtexView<CR>
nnoremap <leader>lc :VimtexClean<CR>
nnoremap <leader>cw :VimtexCountWords<CR>
