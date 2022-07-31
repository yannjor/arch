-- Install packer automatically
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    is_bootstrap = true
    vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    vim.cmd([[packadd packer.nvim]])
end

require("packer").startup(function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")
    -------------------------
    -- General enhancements
    -------------------------
    -- Filetree
    use("kyazdani42/nvim-tree.lua")
    -- Commenting
    use("numToStr/Comment.nvim")
    -- Better syntax highlighting
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    })
    -- Tabs like any other editor
    use("akinsho/bufferline.nvim")
    -- Auto pairs for brackets etc.
    use("windwp/nvim-autopairs")
    -- Git diffs in sign column
    use("lewis6991/gitsigns.nvim")
    -- Telescope (fuzzy finder)
    use("nvim-lua/popup.nvim")
    use("nvim-lua/plenary.nvim")
    use("nvim-telescope/telescope.nvim")
    -- Quickly toggle terminal while editing
    use("akinsho/toggleterm.nvim")
    -- Git UI
    use("TimUntersberger/neogit")
    use("sindrets/diffview.nvim")
    -- Language support
    use("lervag/vimtex")
    -- Faster startup
    use("lewis6991/impatient.nvim")
    -------------------------
    -- LSP & Completion
    -------------------------
    use("neovim/nvim-lspconfig")
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")
    use("nvim-lua/lsp_extensions.nvim")
    use("onsails/lspkind-nvim")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/nvim-cmp")
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")
    use("ray-x/lsp_signature.nvim")
    use("jose-elias-alvarez/null-ls.nvim")
    -- Extra snippets
    use("rafamadriz/friendly-snippets")

    -------------------------
    -- Visual enhancements & themes
    -------------------------
    -- Status line
    use("nvim-lualine/lualine.nvim")
    -- Standalone UI for nvim-lsp progress
    use("j-hui/fidget.nvim")
    -- Show current code context
    use("SmiteshP/nvim-navic")
    -- Diagnostic lines
    use({
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
            require("lsp_lines").setup()
        end,
    })
    -- Icons
    use("kyazdani42/nvim-web-devicons")
    -- Gruvbox
    use("morhetz/gruvbox")
    -- Modified gruvbox
    use("sainnhe/gruvbox-material")
    -- if gruvbox and tokyonight had a baby
    use("rebelot/kanagawa.nvim")
    -- Github theme
    use("projekt0n/github-nvim-theme")
    -- Nightfox theme
    use("EdenEast/nightfox.nvim")
    -- Vscode theme
    use("Mofiqul/vscode.nvim")
    -- Material theme
    use("marko-cerovac/material.nvim")
    -- Catppuccin
    use({ "catppuccin/nvim", as = "catppuccin" })

    if is_bootstrap then
        require("packer").sync()
    end
end)

if is_bootstrap then
    print("==================================")
    print("    Plugins are being installed")
    print("    Wait until Packer completes,")
    print("       then restart nvim")
    print("==================================")
    return
end

-------------------------------------------------
-- Settings
-------------------------------------------------

local o = vim.opt
local g = vim.g

-- Use space as leader key
g.mapleader = " "

-- Enable syntax highlighting
o.syntax = "enable"

-- Do not wrap long lines
o.wrap = false

-- Allow hidden buffers
o.hidden = true

-- Use utf-8
o.encoding = "utf-8"
o.fileencoding = "utf-8"

-- Better display for messages
o.cmdheight = 2

-- Faster diagnostic messages
o.updatetime = 300

-- Enable mouse usage (all modes) in terminals
o.mouse = "a"

-- Sane splits
o.splitbelow = true
o.splitright = true

-- Tabs as 4 spaces
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.smarttab = true
o.expandtab = true

-- Auto indent
o.smartindent = true
o.autoindent = true

-- Show line numbers
o.number = true
o.relativenumber = true

-- Show column
o.colorcolumn = "100"

-- Wrap at 100
o.textwidth = 100

-- Prevent buffer moving when adding/deleting sign.
o.signcolumn = "yes"

-- Indicate that a dark background should be used
o.background = "dark"

-- Enable colors in the terminal UI
o.termguicolors = true

-- Decent wildmenu
o.wildmenu = true
o.wildmode = "list:longest"

-- Show whitespace characters
o.listchars = {
    space = "⋅",
    tab = "__",
    trail = "•",
    extends = "❯",
    precedes = "❮",
    nbsp = "_",
}
o.list = true

-- Don't highlight searches
o.hlsearch = false

-- Ignore case when searching
o.ignorecase = true

-- Case sensitive search if uppercase
o.smartcase = true

-- Permanent undo
o.undodir = os.getenv("HOME") .. "/.vimdid"
o.undofile = true

-- Don't continue comments when using o/O
o.formatoptions:remove("o")

-- Plugin settings
g.vimtex_view_method = "zathura"
g.vimtex_quickfix_mode = 0
-- Ignore default mappings, define own
g.vimtex_mappings_enabled = 0

-------------------------------------------------
-- Keymaps
-------------------------------------------------

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

-------------------------------------------------
-- Plugin setups
-------------------------------------------------

require("impatient")

local lspkind = require("lspkind")
lspkind.init()

local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    completion = {
        completeopt = "menu,menuone,noinsert",
    },
    mapping = {
        -- Accept currently selected item.
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        -- Close completion menu
        ["<C-e>"] = cmp.mapping.close(),
        -- Open completion menu
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        -- If you want tab completion :'(
        --  First you have to just promise to read `:help ins-completion`.
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expandable() then
                luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer", keyword_length = 5 },
        { name = "path" },
    },
    formatting = {
        -- Youtube: How to set up nice formatting for your sources.
        -- https://youtu.be/_DnmphIwnjo?t=816
        format = lspkind.cmp_format({
            with_text = true,
            menu = {
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                luasnip = "[Snippet]",
                path = "[Path]",
            },
        }),
    },
    experimental = {
        ghost_text = true,
    },
})

local navic = require("nvim-navic")

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    local lsp_keymap_opts = { noremap = true, silent = true }

    local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
    }
    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end
    vim.diagnostic.config({ signs = { active = signs }, virtual_text = false })

    buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", lsp_keymap_opts)
    buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", lsp_keymap_opts)
    buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", lsp_keymap_opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", lsp_keymap_opts)
    buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", lsp_keymap_opts)
    buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", lsp_keymap_opts)
    buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", lsp_keymap_opts)
    buf_set_keymap("n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", lsp_keymap_opts)
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", lsp_keymap_opts)
    buf_set_keymap("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", lsp_keymap_opts)
    buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", lsp_keymap_opts)
    buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", lsp_keymap_opts)
    buf_set_keymap("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", lsp_keymap_opts)
    buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.format()<CR>", lsp_keymap_opts)

    local disable_formatting = {
        "hls",
        "html",
        "jsonls",
        "sumneko_lua",
        "tsserver",
    }
    -- Disable formatting for certain LSPs, use null-ls instead
    for _, c in pairs(disable_formatting) do
        if client.name == c then
            client.server_capabilities.document_formatting = false
        end
    end
    navic.attach(client, bufnr)
end

-- Optional and additional LSP setup options other than (common) on_attach, capabilities, etc.
local lsp_setup_opts = {}

lsp_setup_opts["rust_analyzer"] = {
    ["rust-analyzer"] = {
        checkOnSave = {
            command = "clippy",
        },
        completion = {
            autoimport = {
                enable = true,
            },
        },
    },
}

lsp_setup_opts["sumneko_lua"] = {
    Lua = {
        diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { "vim" },
        },
    },
}

lsp_setup_opts["pyright"] = {
    python = {
        analysis = {
            typeCheckingMode = "off",
        },
    },
}

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
for server, settings in pairs(lsp_setup_opts) do
    require("lspconfig")[server].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = settings,
    })
end

-- Attach hls separately
require("lspconfig").hls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

require("mason").setup({})
require("mason-lspconfig").setup({
    ensure_installed = { "sumneko_lua", "pyright", "rust_analyzer" },
})

require("lsp_lines").setup({})
keymap("", "<Leader>L", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })

require("nvim-autopairs").setup({
    check_ts = true, -- treesitter integration
    disable_filetype = { "TelescopePrompt" },
})

require("bufferline").setup({
    options = {
        diagnostics = "nvim_lsp",
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "Directory",
                text_align = "left",
            },
        },
    },
})

-- Gruvbox
vim.cmd([[
  let g:gruvbox_material_background = 'hard'
  colorscheme gruvbox-material
]])

-- require("catppuccin").setup({})
-- vim.cmd([[
--     colorscheme catppuccin
-- ]])

require("Comment").setup({})

require("fidget").setup({})

require("gitsigns").setup({
    signs = {
        add = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
        change = { hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
        delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
        topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
        changedelete = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    },
})

require("lualine").setup({
    options = {
        theme = "gruvbox-material",
        -- theme = "catppuccin",
        icons_enabled = true,
    },
    sections = {
        lualine_c = {
            { navic.get_location, cond = navic.is_available },
        },
    },
})

local ls = require("luasnip")
local _ = require("luasnip.loaders.from_vscode").lazy_load()

ls.config.set_config({
    -- This tells LuaSnip to remember to keep around the last snippet.
    -- You can jump back into it even if you move outside of the selection
    history = true,

    -- This one is cool cause if you have dynamic snippets, it updates as you type!
    updateevents = "TextChanged,TextChangedI",
})

require("neogit").setup({
    disable_commit_confirmation = true,
    integrations = {
        diffview = true,
    },
})

local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

local sources = {
    -- Diagnostics
    diagnostics.shellcheck.with({
        diagnostics_format = "[#{c}] #{m} (#{s})",
    }),
    -- diagnostics.pylint.with({
    --     diagnostics_format = "[#{c}] #{m} (#{s})",
    -- }),

    -- Formatting formatting.prettier,
    formatting.autopep8,
    formatting.shfmt.with({
        extra_args = { "-i", "4", "-sr", "-ci" },
    }),
    formatting.stylua.with({
        extra_args = { "--indent-type", "Spaces" },
    }),
    -- Haskell
    formatting.brittany,

    -- Code actions
    code_actions.shellcheck,
    code_actions.eslint,
}

null_ls.setup({ sources = sources })

require("nvim-tree").setup({})

require("toggleterm").setup({
    -- size can be a number or function which is passed the current terminal
    open_mapping = [[<c-\>]],
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    persist_size = true,
    direction = "float",
    close_on_exit = true, -- close the terminal window when the process exits
    shell = vim.o.shell, -- change the default shell
    -- This field is only relevant if direction is set to 'float'
    float_opts = {
        -- The border key is *almost* the same as 'nvim_open_win'
        -- see :h nvim_open_win for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        border = "curved",
        winblend = 3,
        highlights = {
            border = "Normal",
            background = "Normal",
        },
    },
})

require("nvim-treesitter.configs").setup({
    highlight = {
        enable = true,
    },
    autopairs = {
        enable = true,
    },
})
