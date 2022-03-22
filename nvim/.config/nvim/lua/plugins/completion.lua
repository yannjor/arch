-------------------------------
-- nvim-cmp: completion support
-------------------------------
-- https://github.com/hrsh7th/nvim-cmp#recommended-configuration
-- ~/.vim/plugged/nvim-cmp/lua/cmp/config/default.lua

vim.o.completeopt = "menu,menuone,noselect"

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
