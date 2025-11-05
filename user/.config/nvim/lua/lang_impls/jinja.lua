return {
    tools = {'html-lsp', 'jinja-lsp'},
    system_deps = {},
    -- lazy = {'uros-5/jinja-lsp'},
    treesitter = {},
    -- null = function(null_ls) return {} end,
    lsp = function(lspconfig, capabilities)
        vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
            pattern = {'*.html'},
            callback = function()
                vim.bo.filetype = 'html'
            end,
        })
        lspconfig.html.setup({
            capabilities = capabilities,
            filetypes = {'html'},
            -- https://code.visualstudio.com/docs/languages/html#_formatting
            settings = {
                html = {
                    format = {
                        unformatted = 'pre,code,textarea,script'
                    }
                }
            }
        })
        lspconfig.jinja_lsp.setup({
            capabilities = capabilities,
            filetypes = {'html'},
            settings = {}
        })
    end,
    dap = function() end,
}
