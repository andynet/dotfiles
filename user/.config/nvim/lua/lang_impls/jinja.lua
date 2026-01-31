return {
    tools = {'html-lsp', 'jinja-lsp'},
    system_deps = {},
    -- lazy = {'uros-5/jinja-lsp'},
    treesitter = {},
    -- null = function(null_ls) return {} end,
    lsp = function(lspconfig, capabilities)
        -- maybe consider this:
        -- https://www.curlylint.org/docs/template-languages
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
                        contentUnformatted = 'pre,code,textarea',  -- I don't know why script does not work here
                        unformatted = 'wbr,script'
                    }
                }
            }
        })
        lspconfig.jinja_lsp.setup({
            capabilities = capabilities,
            filetypes = {'html'},
            -- /home/balaz/.local/share/nvim/mason/share/mason-schemas/lsp/jinja-lsp.json
            -- settings = {
            --     ['jinja-lsp'] = {
            --         hide_undefined = true,
            --         template_extension = {}
            --     }
            -- }
        })
    end,
    dap = function() end,
}
