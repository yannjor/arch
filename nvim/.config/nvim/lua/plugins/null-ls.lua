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

    -- Formatting
    formatting.prettier,
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
