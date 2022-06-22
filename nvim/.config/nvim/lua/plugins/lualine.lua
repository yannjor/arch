local navic = require("nvim-navic")

require("lualine").setup({
    options = {
        theme = "gruvbox_dark",
        -- theme = "kanagawa",
        -- theme = "duskfox",
        -- theme = "github_dark",
        -- theme = "vscode",
        -- theme = "material",
        -- theme = "catppuccin",
        icons_enabled = true,
    },
    sections = {
        lualine_c = {
            { navic.get_location, cond = navic.is_available },
        },
    },
})
