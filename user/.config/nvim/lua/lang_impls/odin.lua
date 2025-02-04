return {
    tools = {'ols'},
    treesitter = {'odin'},
    lsp = function(lspconfig, capabilities)
        lspconfig.ols.setup({capabilities = capabilities})
    end,
}
