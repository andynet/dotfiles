-- TODO: replace with https://github.com/mrcjkb/rustaceanvim???
-- TODO: add https://github.com/facebookexperimental/MIRAI
return {
    tools = {'rust-analyzer', 'codelldb'},
    treesitter = {'rust'},
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
    dap = function(dap)
        -- TODO: try this https://jonboh.dev/posts/rr/
        -- https://aur.archlinux.org/packages/rr
        dap.adapters.codelldb = {
            type = 'server',
            port = '${port}',
            executable = {
                command = vim.fn.stdpath('data') .. '/mason/bin/codelldb',
                args = {'--port', '${port}'},
            },
        }
        dap.configurations.rust = {{
            name = 'Launch',
            type = 'codelldb',
            request = 'launch',
            program = function()
                return vim.fn.input('executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            args = function()
                return vim.split(vim.fn.input('args: '), ' ')
            end
        }}
    end,
    lazy = {
        'saecki/crates.nvim',
        tag = 'stable',
        config = function()
            require('crates').setup({})
        end,
    }
}
