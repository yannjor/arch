require("lualine").setup({
    options = {
        theme = "gruvbox_dark",
        -- icons_enabled = false,
    },
    sections = {
        lualine_c = { "LspStatus()" },
    },
})
