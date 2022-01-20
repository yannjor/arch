-------------------------------
-- nvim-cmp: completion support
-------------------------------
-- https://github.com/hrsh7th/nvim-cmp#recommended-configuration
-- ~/.vim/plugged/nvim-cmp/lua/cmp/config/default.lua

vim.o.completeopt = "menu,menuone,noselect"

local lspkind = require("lspkind")
lspkind.init()

local cmp = require("cmp")

cmp.setup({
    snippet = {
        -- REQUIRED by nvim-cmp.
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    documentation = {
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, -- in a clockwise order
    },
    mapping = {
        -- Accept currently selected item.
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        -- Close completion menu
        ["<C-e>"] = cmp.mapping.close(),
        -- If you want tab completion :'(
        --  First you have to just promise to read `:help ins-completion`.
        ["<Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end,
        ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end,
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "vsnip" },
        { name = "buffer", keyword_length = 5 },
        { name = "cmp_tabnine" },
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
                path = "[Path]",
                tn = "[Tabnine]",
            },
        }),
    },
    experimental = {
        ghost_text = true,
    },
})
