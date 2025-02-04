-- https://github.com/HiPhish/jinja.vim

return {
    tools = {},
    system_deps = {},
    lazy = {'uros-5/jinja-lsp'},
    treesitter = {},
    null = function(null_ls) return {} end,
    lsp = function(lspconfig, capabilities)
        vim.filetype.add{
            extension = {
                jinja = 'jinja',
                jinja2 = 'jinja',
                j2 = 'jinja',
            },
        }
        lspconfig.jinja_lsp.setup({
            capabilities = capabilities,
        })
    end,
    dap = function() end,
}
