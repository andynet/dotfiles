return {{
    'williamboman/mason.nvim',
    config = function()
        require('mason').setup()
    end
}, {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    config = function()
        require('mason-tool-installer').setup({
            ensure_installed = {
                'lua-language-server',
                'shellcheck',
            }
        })
    end
}, {
    'neovim/nvim-lspconfig',
    dependencies = 'hrsh7th/cmp-nvim-lsp',
    config = function()
        local lspconfig = require('lspconfig')
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        lspconfig.lua_ls.setup({capabilities = capabilities})

        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {desc = 'Go to definition'})
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, {desc = 'Go to references'})

        vim.keymap.set('n', 'K', vim.lsp.buf.hover, {desc = 'Hover'})
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, {desc = 'Signature help'})
        vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float, {desc = 'Diagnostic'})
        vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist, {desc = 'List diagnostics'})
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
                -- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
                null_ls.builtins.diagnostics.shellcheck
            },
        })
    end
}}
