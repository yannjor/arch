-------------
-- LSP config
-------------
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
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
    local opts = { noremap = true, silent = true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap("n", "<space>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

    -- Disable formatting for tsserver and html - use prettier instead
    if client.name == "tsserver" or client.name == "html" then
        client.resolved_capabilities.document_formatting = false
    end
end

-- Language servers
local servers = {
    "pyright",
    "rust_analyzer",
    "tsserver",
    "bashls",
    "jsonls",
    "yamlls",
    "dockerls",
    "cssls",
    "html",
    "sumneko_lua",
}

-- Optional and additional LSP setup options other than (common) on_attach, capabilities, etc.
local lsp_setup_opts = {}

lsp_setup_opts["rust_analyzer"] = {
    settings = {
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
    },
}

lsp_setup_opts["sumneko_lua"] = {
    settings = {
        Lua = {
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
        },
    },
}

local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = on_attach,

        -- Suggested configuration by nvim-cmp
        capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    }

    -- Customize the options passed to the server
    opts = vim.tbl_extend("error", opts, lsp_setup_opts[server.name] or {})

    -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
    server:setup(opts)
    vim.cmd([[ do User LspAttachBuffers ]])
end)

-- Automatically install if a required LSP server is missing.
for _, lsp_name in ipairs(servers) do
    local ok, lsp = require("nvim-lsp-installer.servers").get_server(lsp_name)

    if ok and not lsp:is_installed() then
        vim.defer_fn(function()
            -- install with a UI so users can be notified
            lsp_installer.install(lsp_name)
        end, 0)
    end
end
