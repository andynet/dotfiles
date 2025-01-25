-- treesitter -> https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
-- tools -> :Mason
-- lsp -> https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
-- dap -> https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
-- nls -> https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md

return {
    tools = {},
    system_deps = {},
    lazy = {},
    treesitter = {},
    null = function(null_ls) end,
    lsp = function(lspconfig, capabilities) end,
    dap = function() end,
}
