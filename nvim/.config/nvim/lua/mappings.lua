-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

-- Standard operations
keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>q", ":q<CR>", opts)
keymap("n", "<leader>c", ":bdelete!<CR>", opts)

-- Quickly insert an empty new line without entering insert mode
keymap("n", "<Leader>o", "o<Esc>", opts)
keymap("n", "<Leader>O", "O<Esc>", opts)

-- Copy-paste
keymap("n", "<leader>p", '"+p', opts)
keymap("v", "<leader>p", '"+p', opts)
keymap("n", "<leader>P", '"+P', opts)
keymap("v", "<leader>P", '"+P', opts)
keymap("n", "<leader>y", '"+y', opts)
keymap("v", "<leader>y", '"+y', opts)
keymap("n", "<leader>Y", '"+y$', opts)

-- Tabs
keymap("n", "<S-l>", ":BufferLineCycleNext<CR>", opts)
keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>", opts)

-- Window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Telescope
keymap("n", "<C-p>", "<cmd>Telescope git_files<CR>", opts)
keymap("n", "<leader>tf", "<cmd>Telescope find_files<CR>", opts)
keymap("n", "<leader>tg", "<cmd>Telescope live_grep<CR>", opts)
keymap("n", "<leader>tb", "<cmd>Telescope buffers<CR>", opts)

--Surround
keymap("v", "<leader>'", "<Esc>`>a'<Esc>`<i'<Esc>", opts)
keymap("v", '<leader>"', '<Esc>`>a"<Esc>`<i"<Esc>', opts)
keymap("v", "<leader>(", "<Esc>`>a,opts)<Esc>`<i(<Esc>")
keymap("v", "<leader>[", "<Esc>`>a]<Esc>`<i[<Esc>", opts)
keymap("v", "<leader>{", "<Esc>`>a}<Esc>`<i{<Esc>", opts)

-- NvimTree
keymap("n", "<C-n>", ":NvimTreeToggle<CR>", opts)

--Vimtex
keymap("n", "<leader>ll", ":VimtexCompile<CR>", opts)
keymap("n", "<leader>lv", ":VimtexView<CR>", opts)
keymap("n", "<leader>lc", ":VimtexClean<CR>", opts)

-- Neogit & Diffview
keymap("n", "<leader>gg", ":Neogit<CR>", opts)
keymap("n", "<leader>gl", ":Neogit log<CR>", opts)
keymap("n", "<leader>gp", ":Neogit push<CR>", opts)
keymap("n", "<leader>gd", ":DiffviewOpen<CR>", opts)
keymap("n", "<leader>gD", ":DiffviewOpen main<CR>", opts)

-- Spell-check
keymap("n", "<leader>se", ":setlocal spell! spelllang=en_us<CR>", opts)
keymap("n", "<leader>ss", ":setlocal spell! spelllang=sv<CR>", opts)
keymap("n", "<leader>sf", ":setlocal spell! spelllang=fr<CR>", opts)
