-- treesitter -> https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
-- tools -> :Mason
-- lsp -> https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
-- dap -> https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
-- nls -> https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md

local languages = {
    rust   = require('languages.rust'),
    python = require('languages.python'),
    c      = require('languages.c'),
    tex    = require('languages.tex'),
    odin   = require('languages.odin'),
    lua    = require('languages.lua'),
    shell  = {
        tools = {'shellcheck'},
        null = function(null_ls)
            return {
                null_ls.builtins.diagnostics.fish,
                require('none-ls-shellcheck.diagnostics'),
                require('none-ls-shellcheck.code_actions'),
            }
        end,
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
            if lang.tools then
                for _, tool in ipairs(lang.tools) do
                    table.insert(tools, tool)
                end
            end
        end

        require('mason-tool-installer').setup({ensure_installed = tools})
    end
}, {
    'neovim/nvim-lspconfig',
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
}, {
    'mfussenegger/nvim-dap',
    config = function()
        local dap = require('dap')

        for _, lang in pairs(languages) do
            if lang.dap then
                lang.dap(dap)
            end
        end

        vim.keymap.set('n', '<F1>', dap.continue, {desc = 'Debug: Start/Continue'})
        vim.keymap.set('n', '<F2>', dap.step_over, {desc = 'Debug: Step Over'})
        vim.keymap.set('n', '<F3>', dap.step_into, {desc = 'Debug: Step Into'})
        vim.keymap.set('n', '<F4>', dap.step_out, {desc = 'Debug: Step Out'})
        vim.keymap.set('n', '<F5>', dap.run_last, {desc = 'Debug: Rerun'})
        vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, {desc = 'Debug: Toggle Breakpoint'})
        vim.keymap.set('n', '<leader>B', function()
            dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
        end, {desc = 'Debug: Set Breakpoint'})
    end
}, {
    'rcarriga/nvim-dap-ui',
    dependencies = {'nvim-neotest/nvim-nio'},
    requires = {'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio'},
    config = function()
        local dapui = require('dapui')
        dapui.setup({
            controls = {enabled = false},
            layouts = {{
                elements = {{id = 'scopes', size = 1.0}},
                position = 'right',
                size = 0.25
            }, {
                elements = {
                    {id = 'console', size = 0.35, position = 'right'},
                    {id = 'repl',    size = 0.65, position = 'left'},
                },
                position = 'bottom',
                size = 0.25
            }}
        })
        vim.keymap.set('n', '<F6>', dapui.toggle, {desc = 'Dapui toggle'})
        vim.keymap.set('n', 'E', dapui.eval, {desc = 'Dapui eval'})
    end
}, {
    'barreiroleo/ltex-extra.nvim'
}}
