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
    use("dylon/vim-antlr")
    -------------------------
    -- LSP & Completion
    -------------------------
    use("neovim/nvim-lspconfig")
    use("williamboman/nvim-lsp-installer")
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
end)

-- Configuration and setup of plugins
require("plugins/autopairs")
require("plugins/bufferline")
require("plugins/colorscheme")
require("plugins/comment")
require("plugins/completion")
require("plugins/fidget")
require("plugins/gitsigns")
require("plugins/lsp")
require("plugins/lualine")
require("plugins/luasnip")
require("plugins/neogit")
require("plugins/null-ls")
require("plugins/nvimtree")
require("plugins/toggleterm")
require("plugins/treesitter")
