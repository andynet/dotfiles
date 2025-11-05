local languages = require('languages')

return {{
    'neovim/nvim-lspconfig',
    branch = 'v2.4.0',  -- since v2.5 require('lspconfig') is deprecated
    dependencies = {'hrsh7th/cmp-nvim-lsp', 'folke/neodev.nvim'},
    config = function()
        local lspconfig = require('lspconfig')
        local capabilities = require('cmp_nvim_lsp').default_capabilities(
            vim.lsp.protocol.make_client_capabilities()
        )

        for _, lang in pairs(languages) do
            if lang.lsp then
                lang.lsp(lspconfig, capabilities)
            end
        end

        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {desc = 'Go to definition'})
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, {desc = 'Go to references'})
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, {desc = 'Hover'})
        vim.keymap.set('n', '<C-K>', vim.lsp.buf.signature_help, {desc = 'Signature help'})
        vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, {desc = 'Code action'})
        vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, {desc = 'Rename symbol'})
        vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float, {desc = 'Diagnostic'})
        vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist, {desc = 'List diagnostics'})
        vim.keymap.set('n', '<Leader>d', vim.diagnostic.goto_next, {desc = 'Go to next diagnostic'})

        vim.keymap.set('n', '<Leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, {desc = 'List workspaces'})

        vim.keymap.set('n', '<Leader>f', function()
            vim.lsp.buf.format({async = true})
        end, {desc = 'Format'})
    end
}, {
    'nvimtools/none-ls.nvim',
    dependencies = {'gbprod/none-ls-shellcheck.nvim',},
    config = function()
        local null_ls = require('null-ls')

        local sources = {}
        for _, lang in pairs(languages) do
            if lang.null then
                local x = lang.null(null_ls)
                for _, source in ipairs(x) do
                    table.insert(sources, source)
                end
            end
        end

        null_ls.setup({sources = sources})
    end
}}
