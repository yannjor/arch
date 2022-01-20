require("Comment").setup({
    -- LHS of operator-pending mapping in NORMAL + VISUAL mode
    opleader = {
        -- line-comment keymap
        line = "<leader>n",
        -- block-comment keymap
        block = "<leader>b",
    },

    -- Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
    mappings = {
        -- operator-pending mapping
        -- Includes:
        --  `gcc`               -> line-comment  the current line
        --  `gcb`               -> block-comment the current line
        --  `gc[count]{motion}` -> line-comment  the region contained in {motion}
        --  `gb[count]{motion}` -> block-comment the region contained in {motion}
        basic = true,

        -- extra mapping
        -- Includes `gco`, `gcO`, `gcA`
        extra = true,

        -- extended mapping
        -- Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
        extended = true,
    },

    -- LHS of toggle mapping in NORMAL + VISUAL mode
    toggler = {
        -- line-comment keymap
        --  Makes sense to be related to your opleader.line
        line = "<leader>nc",

        -- block-comment keymap
        --  Make sense to be related to your opleader.block
        block = "<leader>bb",
    },

    -- Pre-hook, called before commenting the line
    --    Can be used to determine the commentstring value
    pre_hook = nil,

    -- Post-hook, called after commenting is done
    --    Can be used to alter any formatting / newlines / etc. after commenting
    post_hook = nil,

    -- Can be used to ignore certain lines when doing linewise motions.
    --    Can be string (lua regex)
    --    Or function (that returns lua regex)
    ignore = nil,
})
