return {
    tools = {'lua-language-server'},
    lsp = function(lspconfig, capabilities)
        require('neodev').setup()
        lspconfig.lua_ls.setup({capabilities = capabilities})
    end,
}
