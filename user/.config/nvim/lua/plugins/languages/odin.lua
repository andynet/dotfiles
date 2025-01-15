return {
    tools = {'ols'},
    lsp = function(lspconfig, capabilities)
        lspconfig.ols.setup({capabilities = capabilities})
    end,
}
