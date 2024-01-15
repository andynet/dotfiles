-- treesitter -> https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
-- tools -> :Mason
-- lsp -> https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
-- dap -> https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
-- nls -> https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md

local languages = {
    rust = {
        tools = {'rust-analyzer', 'codelldb'},
        lsp = function(lspconfig, capabilities)
            lspconfig.rust_analyzer.setup({
                capabilities = capabilities,
                settings = {
                    ['rust-analyzer'] = {
                        check = {
                            command = 'clippy',
                            ignore = {'clippy::needless_return'}
                        },
                    }
                }
            })
        end,
        dap = function() end,
        null = {},
    },
    python = {
        tools = {'python-lsp-server', 'mypy', 'debugpy', 'black'},
        lsp = function() end,
        dap = function() end,
        null = {},
    },
    c = {
        tools = {'clangd', 'codelldb'},
        lsp = function(lspconfig, capabilities)
            lspconfig.clangd.setup({capabilities = capabilities})
        end,
        dap = function() end,
        null = {},
    },
    lua = {
        tools = {'lua-language-server'},
        lsp = function(lspconfig, capabilities)
            lspconfig.lua_ls.setup({capabilities = capabilities})
        end,
        dap = function() end,
        null = {},
    },
    shell = {
        tools = {'shellcheck'},
        lsp = function() end,
        dap = function() end,
        null = {},
    },
    tex = {
        tools = {'texlab', 'tectonic'}, -- ltex-ls (for grammar check), tectonic (self-contained TeX/LaTeX engine)
        lsp = function(lspconfig, capabilities)
            lspconfig.texlab.setup({
                capabilities = capabilities,
                settings = {
                    texlab = {
                        build = {
                            executable = 'tectonic',
                            args = {'%f', '--synctex', '--keep-logs', '--keep-intermediates'},
                            -- executable = 'latemk',
                            -- args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
                            onSave = true
                        },
                    }
                }
            })
        end,
        dap = function() end,
        null = {},
    },
}

return {{
    'williamboman/mason.nvim',
    config = function() require('mason').setup() end
}, {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    config = function()
        local tools = {}
        for _, lang in pairs(languages) do
            for _, tool in ipairs(lang.tools) do
                table.insert(tools, tool)
            end
        end

        require('mason-tool-installer').setup({ensure_installed = tools})
    end
}, {
    'neovim/nvim-lspconfig',
    dependencies = 'hrsh7th/cmp-nvim-lsp',
    config = function()
        local lspconfig = require('lspconfig')
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        for _, lang in pairs(languages) do
            lang.lsp(lspconfig, capabilities)
        end

        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {desc = 'Go to definition'})
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, {desc = 'Go to references'})

        vim.keymap.set('n', 'K', vim.lsp.buf.hover, {desc = 'Hover'})
        vim.keymap.set('n', '<C-K>', vim.lsp.buf.signature_help, {desc = 'Signature help'})
        vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float, {desc = 'Diagnostic'})
        vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist, {desc = 'List diagnostics'})
        vim.keymap.set('n', '<Leader>d', vim.diagnostic.goto_next, {desc = 'Go to next diagnostic'})
        vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, {desc = 'Code action'})
        vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, {desc = 'Rename symbol'})

        vim.keymap.set('n', '<Leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, {desc = 'List workspaces'})

        vim.keymap.set('n', '<Leader>f', function()
            vim.lsp.buf.format({async = true})
        end, {desc = 'Format'})
    end
}, {
    'nvimtools/none-ls.nvim',
    config = function()
        local null_ls = require('null-ls')
        null_ls.setup({
            sources = {
                null_ls.builtins.diagnostics.shellcheck,
                null_ls.builtins.diagnostics.fish
            },
        })
    end
}}
