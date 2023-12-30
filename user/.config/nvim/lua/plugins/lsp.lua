return { {
    'williamboman/mason.nvim',
    config = function()
        require('mason').setup()
    end
}, {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    config = function()
        require('mason-tool-installer').setup({
            ensure_installed = {
                'lua-language-server'
            }
        })
    end
}, {
    'neovim/nvim-lspconfig',
    config = function()
        local lspconfig = require('lspconfig')
        lspconfig.lua_ls.setup({})

        vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references)

        vim.keymap.set('n', 'K', vim.lsp.buf.hover)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help)
        vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float)
        vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist)
        vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action)
        vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename)

        vim.keymap.set('n', '<Leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end)

        vim.keymap.set('n', '<Leader>f', function()
            vim.lsp.buf.format({ async = true })
        end)
    end
} }
