require("packer").startup(function()
  -- Packer can manage itself
  use("wbthomason/packer.nvim")

  -- VIM enhancements
  use("preservim/nerdtree")
  -- Git integration in file tree
  use("Xuyuanp/nerdtree-git-plugin")
  -- Commenting
  use("preservim/nerdcommenter")
  -- Better syntax highlighting
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate"
  }
  -- Auto pairs for brackets etc.
  use("windwp/nvim-autopairs")

  -- Git wrapper
  use("tpope/vim-fugitive")
  -- Git diffs in sign column
  use("lewis6991/gitsigns.nvim")

  -- LSP
  use("neovim/nvim-lspconfig")
  use("williamboman/nvim-lsp-installer")
  use("nvim-lua/lsp-status.nvim")
  use("nvim-lua/lsp_extensions.nvim")
  use("onsails/lspkind-nvim")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
    },
  }
  use("ray-x/lsp_signature.nvim")

  -- Telescope (fuzzy finder)
  use("nvim-lua/popup.nvim")
  use("nvim-lua/plenary.nvim")
  use("nvim-telescope/telescope.nvim")

  -- Visual enhancements
  -- Status line
  use("nvim-lualine/lualine.nvim")
  -- Icons
  use("kyazdani42/nvim-web-devicons")
  -- Modified gruvbox
  use("sainnhe/gruvbox-material")

  -- Language support
  use("lervag/vimtex")

end)

require("plugins/lualine")
require("plugins/gitsigns")
require("plugins/lsp")
require("plugins/treesitter")
require("plugins/autopairs")
