return {
    tools = {'codelldb'},
    system_deps = {'clangd'},
    lsp = function(lspconfig, capabilities)
        lspconfig.clangd.setup({
            capabilities = capabilities,
            filetypes = {'c', 'h'},
            cmd = {
                'clangd',
                '--log=verbose',
                '--clang-tidy',
                '--header-insertion=never'
            }
        })
    end,
    dap = function() end,
    -- cppcheck
}
