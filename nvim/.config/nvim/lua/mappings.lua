-- Wrapper functions
local nnoremap = function(lhs, rhs, silent)
    vim.api.nvim_set_keymap("n", lhs, rhs, { noremap = true, silent = silent })
end

local inoremap = function(lhs, rhs)
    vim.api.nvim_set_keymap("i", lhs, rhs, { noremap = true })
end

local vnoremap = function(lhs, rhs)
    vim.api.nvim_set_keymap("v", lhs, rhs, { noremap = true })
end

local nmap = function(lhs, rhs)
    vim.api.nvim_set_keymap("n", lhs, rhs, {})
end

local map = function(lhs, rhs)
    vim.api.nvim_set_keymap("", lhs, rhs, {})
end

-- Quick-save
nmap("<leader>w", ":w<CR>")

-- Quickly insert an empty new line without entering insert mode
nnoremap("<Leader>o", "o<Esc>")
nnoremap("<Leader>O", "O<Esc>")

-- Copy-paste
nnoremap("<leader>p", '"+p')
vnoremap("<leader>p", '"+p')
nnoremap("<leader>P", '"+P')
vnoremap("<leader>P", '"+P')
nnoremap("<leader>y", '"+y')
vnoremap("<leader>y", '"+y')
nnoremap("<leader>Y", '"+y$')

-- Random remaps
nnoremap("Y", "y$")
nnoremap("cn", "*``cgn")
nnoremap("cN", "*``cgN")

-- Tabs
nnoremap("<S-l>", ":BufferLineCycleNext<CR>")
nnoremap("<S-h>", ":BufferLineCyclePrev<CR>")

-- Window navigation
nnoremap("<C-h>", "<C-w>h")
nnoremap("<C-j>", "<C-w>j")
nnoremap("<C-k>", "<C-w>k")
nnoremap("<C-l>", "<C-w>l")

-- Move lines
vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")
nnoremap("<leader>k", ":m .-2<CR>==")
nnoremap("<leader>j", ":m .+1<CR>==")
inoremap("<C-k>", "<esc>:m .-2<CR>==")
inoremap("<C-j>", "<esc>:m .+1<CR>==")

-- Telescope
nnoremap("<C-p>", "<cmd>Telescope git_files<cr>")
nnoremap("<leader>tf", "<cmd>Telescope find_files<cr>")
nnoremap("<leader>tg", "<cmd>Telescope live_grep<cr>")
nnoremap("<leader>tb", "<cmd>Telescope buffers<cr>")

--Surround
vnoremap("<leader>'", "<esc>`>a'<esc>`<i'<esc>")
vnoremap('<leader>"', '<esc>`>a"<esc>`<i"<esc>')
vnoremap("<leader>(", "<esc>`>a)<esc>`<i(<esc>")
vnoremap("<leader>[", "<esc>`>a]<esc>`<i[<esc>")
vnoremap("<leader>{", "<esc>`>a}<esc>`<i{<esc>")

-- NvimTree
map("<C-n>", ":NvimTreeToggle<CR>")

--Vimtex
nnoremap("<leader>ll", ":VimtexCompile<CR>")
nnoremap("<leader>lv", ":VimtexView<CR>")
nnoremap("<leader>lc", ":VimtexClean<CR>")

-- Spell-check
map("<leader>se", ":setlocal spell! spelllang=en_us<CR>")
map("<leader>ss", ":setlocal spell! spelllang=sv<CR>")
map("<leader>sf", ":setlocal spell! spelllang=fr<CR>")

-- Completion: Jump forward or backward in snippets
vim.cmd([[
  imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
  smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
  imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
  smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
]])
